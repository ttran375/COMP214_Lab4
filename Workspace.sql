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
-- Step 2: Anonymous block to test the package procedures and function
CREATE OR REPLACE PACKAGE order_info_pkg AS

  FUNCTION ship_name_pf(
    p_id IN NUMBER
  ) RETURN VARCHAR2;

  FUNCTION basket_info_pp(
    p_id IN NUMBER
  ) RETURN VARCHAR2;
END order_info_pkg;
/

CREATE OR REPLACE PACKAGE BODY order_info_pkg AS

  FUNCTION ship_name_pf(
    p_id IN NUMBER
  ) RETURN VARCHAR2 IS
  BEGIN
 -- Your implementation to fetch ship name based on p_id
    RETURN 'Sample Ship Name';
  END ship_name_pf;

  FUNCTION basket_info_pp(
    p_id IN NUMBER
  ) RETURN VARCHAR2 IS
  BEGIN
 -- Your implementation to fetch basket info based on p_id
    RETURN 'Sample Basket Info';
  END basket_info_pp;
END order_info_pkg;
/

DECLARE
  v_ship_name VARCHAR2(100);
BEGIN
  v_ship_name := order_info_pkg.ship_name_pf(12);
 -- Use v_ship_name as needed
  DBMS_OUTPUT.PUT_LINE('Ship Name: '
                       || v_ship_name);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: '
                         || SQLERRM);
END;
/
