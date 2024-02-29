-- Assignment 5-6: Returning Order Status Information
-- Create a procedure that returns the most recent order status information for a specified basket.
-- This procedure should determine the most recent ordering-stage entry in the BB_BASKETSTATUS
-- table and return the data. Use an IF or CASE clause to return a stage description instead
-- of an IDSTAGE number, which means little to shoppers. The IDSTAGE column of the
-- BB_BASKETSTATUS table identifies each stage as follows:
-- • 1—Submitted and received
-- • 2—Confirmed, processed, sent to shipping
-- • 3—Shipped
-- • 4—Cancelled
-- • 5—Back-ordered
-- The procedure should accept a basket ID number and return the most recent status
-- description and date the status was recorded. If no status is available for the specified basket
-- ID, return a message stating that no status is available. Name the procedure STATUS_SP. Test
-- the procedure twice with the basket ID 4 and then 6.

CREATE OR REPLACE PROCEDURE STATUS_SP (
  basket_id_param IN bb_basket.idBasket%TYPE,
  status_desc OUT VARCHAR2,
  status_date OUT DATE
) AS
  lv_status_id bb_basketstatus.idStatus%TYPE;
  lv_stage_id  bb_basketstatus.idStage%TYPE;
BEGIN
 -- Get the most recent status ID for the specified basket ID
  SELECT
    MAX(idStatus) INTO lv_status_id
  FROM
    bb_basketstatus
  WHERE
    idBasket = basket_id_param;
 -- Check if there is a status available for the specified basket ID
  IF lv_status_id IS NOT NULL THEN
 -- Get the stage ID and status date for the most recent status
    SELECT
      idStage,
      dtStage INTO lv_stage_id,
      status_date
    FROM
      bb_basketstatus
    WHERE
      idStatus = lv_status_id;
 -- Return the stage description based on the stage ID
    CASE lv_stage_id
      WHEN 1 THEN
        status_desc := 'Submitted and received';
      WHEN 2 THEN
        status_desc := 'Confirmed, processed, sent to shipping';
      WHEN 3 THEN
        status_desc := 'Shipped';
      WHEN 4 THEN
        status_desc := 'Cancelled';
      WHEN 5 THEN
        status_desc := 'Back-ordered';
    END CASE;
  ELSE
 -- If no status is available for the specified basket ID, return a message
    status_desc := 'No status available';
    status_date := NULL;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    status_desc := 'No status available';
    status_date := NULL;
END STATUS_SP;
/

DECLARE
  lv_status_desc VARCHAR2(100);
  lv_status_date DATE;
BEGIN
 -- Test with basket ID 4
  STATUS_SP(4, lv_status_desc, lv_status_date);
  DBMS_OUTPUT.PUT_LINE('Basket 4 Status: '
                       || lv_status_desc
                       || ' (Date: '
                       || TO_CHAR(v_status_date, 'DD-MON-YYYY')
                          || ')');
 -- Test with basket ID 6
  STATUS_SP(6, lv_status_desc, lv_status_date);
  DBMS_OUTPUT.PUT_LINE('Basket 6 Status: '
                       || lv_status_desc
                       || ' (Date: '
                       || TO_CHAR(v_status_date, 'DD-MON-YYYY')
                          || ')');
END;
