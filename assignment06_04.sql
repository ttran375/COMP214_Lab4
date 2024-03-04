-- Assignment 6-4: Identifying the Weekday for an Order Date
-- The day of the week that baskets are created is often analyzed to determine consumershopping patterns. Create a function named DAY_ORD_SF that accepts an order date and
-- returns the weekday. Use the function in a SELECT statement to display each basket ID and the
-- weekday the order was created. Write a second SELECT statement, using this function to
-- display the total number of orders for each weekday. (Hint: Call the TO_CHAR function to retrieve
-- the weekday from a date.)
-- 1. Develop and run a CREATE FUNCTION statement to create the DAY_ORD_SF function. Use
-- the DTCREATED column of the BB_BASKET table as the date the basket is created. Call
-- the TO_CHAR function with the DAY option to retrieve the weekday for a date value.
-- 2. Create a SELECT statement that lists the basket ID and weekday for every basket.
-- 3. Create a SELECT statement, using a GROUP BY clause to list the total number of baskets
-- per weekday. Based on the results, what’s the most popular shopping day?

-- 1. Create the DAY_ORD_SF function
CREATE OR REPLACE FUNCTION DAY_ORD_SF(
  order_date IN DATE
) RETURN VARCHAR2 IS
BEGIN
  RETURN TO_CHAR(order_date, 'Day');
END;
/

-- 2. Use the function to display each basket ID and the weekday
SELECT
  idBasket,
  DAY_ORD_SF(dtCreated) AS weekday
FROM
  bb_basket;

-- 3. Use the function in another SELECT statement with a GROUP BY clause
--    to list the total number of baskets per weekday
SELECT
  DAY_ORD_SF(dtCreated) AS weekday,
  COUNT(*)              AS total_orders
FROM
  bb_basket
GROUP BY
  DAY_ORD_SF(dtCreated)
ORDER BY
  total_orders DESC;
