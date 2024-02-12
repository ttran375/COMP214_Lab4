-- Assignment 3-1: Querying Data in a Block
-- A Brewbean’s application page is being developed for employees to enter a basket number and
-- view shipping information for the order that includes date, shipper, and shipping number. An
-- IDSTAGE value of 5 in the BB_BASKETSTATUS table indicates that the order has been
-- shipped. In this assignment, you create a block using scalar variables to hold the data retrieved
-- from the database. Follow these steps to create a block for checking shipping information:
-- 1. Start SQL Developer, if necessary.
-- 2. Open the assignment03-01.sql file in the Chapter03 folder.
-- 3. Review the code, and note the use of scalar variables to hold the values retrieved in the
-- SELECT statement.
-- 4. Add data type assignments to the first three variables declared. These variables will be
-- used to hold data retrieved from a query.
-- 5. Run the block for basket ID 3, and compare the results with Figure 3-29.
-- 6. Now try to run this same block with a basket ID that has no shipping information recorded.
-- Edit the basket ID variable to be 7.
-- 7. Run the block again, and review the error shown in Figure 3-30.
DECLARE
    lv_ship_date   bb_basketstatus.dtstage%TYPE := SYSDATE;
    lv_shipper_txt bb_basketstatus.shipper%TYPE := 'Default Shipper';
    lv_ship_num    bb_basketstatus.shippingnum%TYPE := 1;
    lv_bask_num    bb_basketstatus.idbasket%TYPE := 3;
 -- lv_bask_num    bb_basketstatus.idbasket%TYPE := 7;
BEGIN
    SELECT
        dtstage,
        shipper,
        shippingnum INTO lv_ship_date,
        lv_shipper_txt,
        lv_ship_num
    FROM
        bb_basketstatus
    WHERE
        idbasket = lv_bask_num
        AND idstage = 5;
    DBMS_OUTPUT.PUT_LINE('Date Shipped: '
                         ||lv_ship_date);
    DBMS_OUTPUT.PUT_LINE('Shipper: '
                         ||lv_shipper_txt);
    DBMS_OUTPUT.PUT_LINE('Shipping #: '
                         ||lv_ship_num);
END;
