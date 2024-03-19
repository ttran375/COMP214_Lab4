-- Assignment 7-2: Using Program Units in a Package
-- In this assignment, you use program units in a package created to store basket information. The
-- package contains a function that returns the recipient’s name and a procedure that retrieves the
-- shopper ID and order date for a basket.
-- 1. In SQL Developer, create the ORDER_INFO_PKG package, using the
-- Assignment07-02.txt file in the Chapter07 folder. Review the code to become familiar
-- with the two program units in the package.
-- 2. Create an anonymous block that calls both the packaged procedure and function with
-- basket ID 12 to test these program units. Use DBMS_OUTPUT statements to display values
-- returned from the program units to verify the data.
-- 3. Also, test the packaged function by using it in a SELECT clause on the BB_BASKET table.
-- Use a WHERE clause to select only the basket 12 row.

BEGIN
 -- Variables to hold output from the procedure
  DECLARE
    v_shop_id        NUMBER;
    v_order_date     DATE;
    v_recipient_name VARCHAR2(100);
 -- Calling the function to get the recipient's name for basket ID 12
    v_recipient_name := ORDER_INFO_PKG.SHIP_NAME_PF(12);
    DBMS_OUTPUT      .PUT_LINE('Recipient Name: '
                               || V_RECIPIENT_NAME);
 -- Calling the procedure to get the shopper ID and order date for basket ID 12
    order_info_pkg   .BASKET_INFO_PP(12, V_SHOP_ID, V_ORDER_DATE);
    DBMS_OUTPUT      .PUT_LINE('Shopper ID: '
                               || V_SHOP_ID
                               || ' Order Date: '
                               || TO_CHAR(V_ORDER_DATE, 'DD-MON-YYYY'));
  END;
/

SELECT
  order_info_pkg.ship_name_pf(idBasket) AS recipient_name
FROM
  bb_basket
WHERE
  idBasket = 12;
