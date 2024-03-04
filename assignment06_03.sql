-- Assignment 6-3: Calculating a Shopper’s Total Number of Orders
-- Another commonly used statistic in reports is the total number of orders a shopper has placed.
-- Follow these steps to create a function named NUM_PURCH_SF that accepts a shopper ID and
-- returns a shopper’s total number of orders. Use the function in a SELECT statement to display
-- the number of orders for shopper 23.
-- 1. Develop and run a CREATE FUNCTION statement to create the NUM_PURCH_SF function.
-- The function code needs to tally the number of orders (using an Oracle built-in function)
-- by shopper. Keep in mind that the ORDERPLACED column contains a 1 if an order has
-- been placed.
-- 2. Create a SELECT query by using the NUM_PURCH_SF function on the IDSHOPPER column
-- of the BB_SHOPPER table. Be sure to select only shopper 23.

-- Step 1: Create the function NUM_PURCH_SF
CREATE OR REPLACE FUNCTION NUM_PURCH_SF(
  p_shopper_id IN NUMBER
) RETURN NUMBER AS
  lv_total_orders NUMBER;
BEGIN
 -- Count the total number of orders for the specified shopper
  SELECT
    COUNT(*) INTO lv_total_orders
  FROM
    bb_basket
  WHERE
    idShopper = p_shopper_id
    AND orderplaced = 1; -- considering 'orderplaced' column contains 1 for placed orders
  RETURN lv_total_orders;
END;
/

-- Step 2: Use the function to display the number of orders for shopper 23
SELECT
  NUM_PURCH_SF(23) AS Total_Orders
FROM
  dual;
