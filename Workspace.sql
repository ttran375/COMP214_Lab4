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
CREATE OR REPLACE PACKAGE order_info_pkg IS

  FUNCTION ship_name_pf (
    p_basket IN NUMBER
  ) RETURN VARCHAR2;

  PROCEDURE basket_info_pp (
    p_basket IN NUMBER,
    p_shop OUT NUMBER,
    p_date OUT DATE
  );
END;
/

CREATE OR REPLACE PACKAGE BODY order_info_pkg IS

  FUNCTION ship_name_pf (
    p_basket IN NUMBER
  ) RETURN VARCHAR2 IS
    lv_name_txt VARCHAR2(25);
  BEGIN
    SELECT
      shipfirstname
      ||' '
      ||shiplastname INTO lv_name_txt
    FROM
      bb_basket
    WHERE
      idBasket = p_basket;
    RETURN lv_name_txt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END ship_name_pf;

  PROCEDURE basket_info_pp (
    p_basket IN NUMBER,
    p_shop OUT NUMBER,
    p_date OUT DATE
  ) IS
  BEGIN
    SELECT
      idshopper,
      dtordered INTO p_shop,
      p_date
    FROM
      bb_basket
    WHERE
      idbasket = p_basket;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END basket_info_pp;
END;
/

-- Create an anonymous block
DECLARE
  lv_id      NUMBER := 12;
  lv_name    VARCHAR2(25);
  lv_shopper bb_basket.idshopper%type;
  lv_date    bb_basket.dtcreated%type;
BEGIN
-- Test these program units
  -- Call the packaged function 
  lv_name := order_info_pkg.ship_name_pf(lv_id);
  -- Use DBMS_OUTPUT statements to display values
  dbms_output.put_line(lv_id
                       ||' '
                       ||lv_name);
  -- Call the packaged procedure
  order_info_pkg.basket_info_pp(lv_id, lv_shopper, lv_date);
  -- Use DBMS_OUTPUT statements to display values
  dbms_output.put_line(lv_id
                       ||' '
                       ||lv_shopper
                       ||' '
                       ||lv_date);
END;
/

-- Test the packaged function by using it in a SELECT clause on the BB_BASKET table
SELECT
  lpad(order_info_pkg.ship_name_pf(idbasket), 20) "ship_name_pf on 12"
FROM
  bb_basket
 -- Use a WHERE clause to select only the basket 12 row. 
WHERE
  idbasket = 12;
/
