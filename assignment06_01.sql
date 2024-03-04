-- Assignment 6-1: Formatting Numbers as Currency
-- Many of the Brewbean’s application pages and reports generated from the database display
-- dollar amounts. Follow these steps to create a function that formats the number provided as
-- an argument with a dollar sign, commas, and two decimal places:
-- 1. Create a function named DOLLAR_FMT_SF with the following code:
-- CREATE OR REPLACE FUNCTION dollar_fmt_sf
-- (p_num NUMBER)
-- RETURN VARCHAR2
-- IS
-- lv_amt_txt VARCHAR2(20);
-- BEGIN
-- lv_amt_txt := TO_CHAR(p_num,'$99,999.99');
-- RETURN lv_amt_txt;
-- END;
-- 2. Test the function by running the following anonymous PL/SQL block. Your results should
-- match Figure 6-23.
-- DECLARE
-- lv_amt_num NUMBER(8,2) := 9999.55;
-- BEGIN
-- DBMS_OUTPUT.PUT_LINE(dollar_fmt_sf(lv_amt_num));
-- END;
-- 3. Test the function with the following SQL statement. Your results should match Figure 6-24.
-- SELECT dollar_fmt_sf(shipping), dollar_fmt_sf(total)
-- FROM bb_basket
-- WHERE idBasket = 3;

-- Step 1: Create a function named DOLLAR_FMT_SF
CREATE OR REPLACE FUNCTION dollar_fmt_sf (
  p_num NUMBER
) RETURN VARCHAR2 IS
  lv_amt_txt VARCHAR2(20);
BEGIN
  lv_amt_txt := TO_CHAR(p_num, '$99,999.99');
  RETURN lv_amt_txt;
END;
/

-- Step 2: Test the function by running the following anonymous PL/SQL block
DECLARE
  lv_amt_num NUMBER(8, 2) := 9999.55;
BEGIN
  DBMS_OUTPUT.PUT_LINE(dollar_fmt_sf(lv_amt_num));
END;
/

-- Step 3: Test the function with the following SQL statement
SELECT
  dollar_fmt_sf(shipping),
  dollar_fmt_sf(total)
FROM
  bb_basket
WHERE
  idBasket = 3;
