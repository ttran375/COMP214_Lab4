-- Assignment 7-1: Creating a Package
-- Follow the steps to create a package containing a procedure and a function pertaining to basket
-- information. (Note: The first time you compile the package body doesn’t give you practice with
-- compilation error messages.)
-- 1. Start Notepad, and open the Assignment07-01.txt file in the Chapter07 folder.
-- 2. Review the package code, and then copy it.
-- 3. In SQL Developer, paste the copied code to build the package.
-- 4. Review the compilation errors and identify the related coding error.
-- 5. Edit the package to correct the error and compile the package.
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
      RAISE_APPLICATION_ERROR(-20001, 'Invalid basket id');
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
      RAISE_APPLICATION_ERROR(-20002, 'Invalid basket id');
  END basket_info_pp;
END;
/
