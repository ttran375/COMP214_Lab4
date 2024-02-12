-- Assignment 3-2: Using a Record Variable
-- A Brewbean’s application page is being developed for employees to enter a basket number
-- and view shipping information for the order. The page needs to display all column values from
-- the BB_BASKETSTATUS table. An IDSTAGE value of 5 in the BB_BASKETSTATUS table
-- indicates that the order has been shipped. Follow these steps to create a block with a
-- record variable:
-- 1. Start SQL Developer, if necessary.
-- 2. Open the assignment03-02.sql file in the Chapter03 folder.
-- 3. Review the code, and note the use of a record variable to hold the values retrieved in the
-- SELECT statement. Also, notice that the record variable’s values are referenced separately
-- in the DBMS_OUTPUT statements.
-- 4. Run the block, and compare the results with Figure 3-31.
DECLARE
  lv_rec_ship bb_basketstatus%ROWTYPE;
  lv_bask_num bb_basketstatus.idbasket%TYPE := 3;
BEGIN
  SELECT
    * INTO lv_rec_ship
  FROM
    bb_basketstatus
  WHERE
    idbasket = lv_bask_num
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '
                       ||lv_rec_ship.dtstage);
  DBMS_OUTPUT.PUT_LINE('Shipper: '
                       ||lv_rec_ship.shipper);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '
                       ||lv_rec_ship.shippingnum);
  DBMS_OUTPUT.PUT_LINE('Notes: '
                       ||lv_rec_ship.notes);
END;
