-- Assignment 3-3: Processing Database Data with IF Statements
-- The Brewbean’s application needs a block to determine whether a customer is rated HIGH,
-- MID, or LOW based on his or her total purchases. The block needs to select the total amount of
-- orders for a specified customer, determine the rating, and then display the results onscreen. The
-- code rates the customer HIGH if total purchases are greater than $200, MID if greater than
-- $100, and LOW if $100 or lower. Use an initialized variable to provide the shopper ID.
-- 1. Start SQL Developer, if necessary.
-- 2. Open the assignment03-03.sql file from the Chapter03 folder. Review the partial block.
-- Edit the block to perform the required task.
-- 3. Run the block and verify the results. Enter and run the following SQL query to confirm that
-- the total for this shopper is indeed greater than $200:
-- SELECT SUM(total)
-- FROM bb_basket
-- WHERE idShopper = 22
-- AND orderplaced = 1
-- GROUP BY idshopper;
-- 4. Test other shoppers who have a completed order.
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
  IF lv_total_num > 200 THEN
    lv_rating_txt := 'HIGH';
  ELSIF lv_total_num > 100 THEN
    lv_rating_txt := 'MID';
  ELSE
    lv_rating_txt := 'LOW';
  END IF;

  DBMS_OUTPUT.PUT_LINE('Shopper '
                       ||lv_shop_num
                       ||' is rated '
                       ||lv_rating_txt);
END;

SELECT
  SUM(total)
FROM
  bb_basket
WHERE
  idShopper = 22
  AND orderplaced = 1
GROUP BY
  idshopper;
