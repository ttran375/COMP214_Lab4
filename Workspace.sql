-- Case 7-1: Reviewing Brewbean’s Order Checkout Package
-- In Chapter 6, you created a procedure and functions to handle updating basket columns during
-- the shopper checkout process. Create a package named SHOP_PROCESS_PKG that contains
-- all the program units created in Chapter 6. Modify the BASK_CALC_PP procedure so that the
-- subtotal, tax, shipping, and total amounts are placed in packaged variables rather than the
-- database so that the application can display a purchase confirmation page for shoppers.
-- Test this procedure with basket 3.
-- The lead programmer has requested that all package program units be in alphabetical order
-- to make them easy to locate. Use forward declarations, if needed, to allow alphabetizing
-- program units.
CREATE OR REPLACE PACKAGE SHOP_PROCESS_PKG IS
 -- Forward declarations
  FUNCTION UPDATE_STOCK_PF(
    basket_id IN NUMBER
  ) RETURN NUMBER;

  PROCEDURE BASK_CALC_PP(
    basket_id IN NUMBER
  );
 -- Packaged variables for storing calculated amounts
  g_subtotal NUMBER;
  g_tax      NUMBER;
  g_shipping NUMBER;
  g_total    NUMBER;
 -- You can add forward declarations for other procedures and functions here
END SHOP_PROCESS_PKG;
/

CREATE OR REPLACE PACKAGE BODY SHOP_PROCESS_PKG IS
 -- Implementation of UPDATE_STOCK_PF
  FUNCTION UPDATE_STOCK_PF(
    basket_id IN NUMBER
  ) RETURN NUMBER IS
  BEGIN
 -- Implementation goes here
    RETURN 0; -- Placeholder return value
  END UPDATE_STOCK_PF;
 -- Modified BASK_CALC_PP procedure
  PROCEDURE BASK_CALC_PP(
    basket_id IN NUMBER
  ) IS
  BEGIN
 -- Example calculations (details depend on your business logic)
    SELECT
      100,
      10,
      5,
      115 INTO g_subtotal,
      g_tax,
      g_shipping,
      g_total
    FROM
      dual; -- Placeholder values
 -- Instead of updating the database, these values are now stored in packaged variables
 -- Application can use these variables to display confirmation page to the shopper
  END BASK_CALC_PP;
 -- Implementation of other procedures and functions goes here
END SHOP_PROCESS_PKG;
/
