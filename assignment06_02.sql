-- Assignment 6-2: Calculating a Shopper’s Total Spending
-- Many of the reports generated from the system calculate the total dollars in a shopper’s
-- purchases. Follow these steps to create a function named TOT_PURCH_SF that accepts a
-- shopper ID as input and returns the total dollars the shopper has spent with Brewbean’s. Use
-- the function in a SELECT statement that shows the shopper ID and total purchases for every
-- shopper in the database.
-- 1. Develop and run a CREATE FUNCTION statement to create the TOT_PURCH_SF function.
-- The function code needs a formal parameter for the shopper ID and to sum the TOTAL
-- column of the BB_BASKET table.
-- 2. Develop a SELECT statement, using the BB_SHOPPER table, to produce a list of each
-- shopper in the database and his or her total purchases.

-- Step 1: Create the function TOT_PURCH_SF
CREATE OR REPLACE FUNCTION TOT_PURCH_SF(
  shopper_id IN NUMBER
) RETURN NUMBER IS
  total_spent NUMBER(7, 2);
BEGIN
 -- Calculate the total dollars spent by the shopper
  SELECT
    SUM(b.Total) INTO total_spent
  FROM
    bb_basket b
  WHERE
    b.idShopper = shopper_id;
  RETURN total_spent;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;
/

-- Step 2: Use the function in a SELECT statement
SELECT
  idShopper,
  TOT_PURCH_SF(idShopper) AS Total_Purchases
FROM
  bb_shopper;

