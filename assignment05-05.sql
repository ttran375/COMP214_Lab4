-- Assignment 5-5: Updating Order Status
-- Create a procedure named STATUS_SHIP_SP that allows an employee in the Shipping
-- Department to update an order status to add shipping information. The BB_BASKETSTATUS
-- table lists events for each order so that a shopper can see the current status, date, and
-- comments as each stage of the order process is finished. The IDSTAGE column of the
-- BB_BASKETSTATUS table identifies each stage; the value 3 in this column indicates that an
-- order has been shipped.
-- The procedure should allow adding a row with an IDSTAGE of 3, date shipped, tracking
-- number, and shipper. The BB_STATUS_SEQ sequence is used to provide a value for the primary
-- key column. Test the procedure with the following information:
-- Basket # = 3
-- Date shipped = 20-FEB-12
-- Shipper = UPS
-- Tracking # = ZW2384YXK4957

-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE STATUS_SHIP_SP (
  p_basket_id IN bb_basket.idBasket%TYPE,
  p_date_shipped IN DATE,
  p_tracking_number IN VARCHAR2,
  p_shipper IN VARCHAR2
) AS
  v_status_id bb_basketstatus.idStatus%TYPE;
BEGIN
 -- Get the next sequence value for the status ID
  SELECT
    bb_status_seq.NEXTVAL INTO v_status_id
  FROM
    dual;
 -- Insert the shipping information into bb_basketstatus table
  INSERT INTO bb_basketstatus (
    idStatus,
    idBasket,
    idStage,
    dtStage,
    shipper,
    ShippingNum
  ) VALUES (
    v_status_id,
    p_basket_id,
    3,
    p_date_shipped,
    p_shipper,
    p_tracking_number
  );
 -- Update the shipflag in bb_basket table
  UPDATE bb_basket
  SET
    shipflag = 'Y'
  WHERE
    idBasket = p_basket_id;
 -- Commit the transaction
  COMMIT;
 -- Display success message
  DBMS_OUTPUT.PUT_LINE('Order status updated successfully.');
EXCEPTION
  WHEN OTHERS THEN
 -- Rollback the transaction if an error occurs
    ROLLBACK;
 -- Display error message
    DBMS_OUTPUT.PUT_LINE('Error updating order status: '
                         || SQLERRM);
END STATUS_SHIP_SP;
/

-- Step 2: Test the procedure with the provided information
BEGIN
  STATUS_SHIP_SP(3, TO_DATE('20-FEB-12', 'DD-MON-YY'), 'UPS', 'ZW2384YXK4957');
END;
