-- Assignment 3-4: Using Searched CASE Statements
-- The Brewbean’s application needs a block to determine whether a customer is rated HIGH,
-- MID, or LOW based on his or her total purchases. The block needs to select the total amount of
-- orders for a specified customer, determine the rating, and then display the results onscreen.
-- The code rates the customer HIGH if total purchases are greater than $200, MID if greater than
-- $100, and LOW if $100 or lower. Use an initialized variable to provide the shopper ID.
-- 1. Start SQL Developer, if necessary.
-- 2. Modify the code used in Assignment 3-3 to use a searched CASE statement to check the
-- shopper’s total purchase amount and determine the correct rating.
-- 3. Run the block, and verify the results.
-- 4. Enter and run the following code to confirm that the total for this shopper is indeed greater
-- than $200:
-- SELECT SUM(total)
-- FROM bb_basket
-- WHERE idShopper = 22
-- AND orderplaced = 1
-- GROUP BY idshopper;
-- 5. Test other shoppers who have a completed order.
DECLARE
  lv_total_num  NUMBER(6, 2);
  lv_rating_txt VARCHAR2(4);
  lv_shop_num   bb_basket.idshopper%TYPE := 22;
BEGIN
  SELECT
    SUM(total) INTO lv_total_num
  FROM
    bb_basket
  WHERE
    idShopper = lv_shop_num
    AND orderplaced = 1
  GROUP BY
    idshopper;
  lv_rating_txt := CASE WHEN lv_total_num > 200 THEN 'HIGH' WHEN lv_total_num > 100 THEN 'MID' ELSE 'LOW' END;
  DBMS_OUTPUT.PUT_LINE('Shopper '
                       ||lv_shop_num
                       ||' is rated '
                       ||lv_rating_txt);
END;
