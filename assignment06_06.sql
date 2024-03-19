-- Assignment 6-6: Adding Descriptions for Order Status Codes
-- When a shopper returns to the Web site to check an order’s status, information from the
-- BB_BASKETSTATUS table is displayed. However, only the status code is available in the
-- BB_BASKETSTATUS table, not the status description. Create a function named STATUS_DESC_SF
-- that accepts a stage ID and returns the status description. The descriptions for stage IDs
-- are listed in Table 6-3. Test the function in a SELECT statement that retrieves all rows in the
-- BB_BASKETSTATUS table for basket 4 and displays the stage ID and its description.
-- Create the function STATUS_DESC_SF
CREATE OR REPLACE FUNCTION STATUS_DESC_SF(
  stage_id IN NUMBER
) RETURN VARCHAR2 IS
  status_desc VARCHAR2(100);
BEGIN
  CASE stage_id
    WHEN 1 THEN
      status_desc := 'Order submitted';
    WHEN 2 THEN
      status_desc := 'Accepted, sent to shipping';
    WHEN 3 THEN
      status_desc := 'Back-ordered';
    WHEN 4 THEN
      status_desc := 'Cancelled';
    WHEN 5 THEN
      status_desc := 'Shipped';
    ELSE
      status_desc := 'Unknown';
  END CASE;

  RETURN status_desc;
END STATUS_DESC_SF;
/

-- Test the function using a SELECT statement
SELECT
  bs.idStage,
  STATUS_DESC_SF(bs.idStage) AS Status_Description
FROM
  bb_basketstatus bs
WHERE
  bs.idBasket = 4;
