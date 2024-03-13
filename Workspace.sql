-- Assignment 7-3: Creating a Package with Private Program Units
-- In this assignment, you modify a package to make program units private. The Brewbean’s
-- programming group decided that the SHIP_NAME_PF function in the ORDER_INFO_PKG
-- package should be used only from inside the package. Follow these steps to make this
-- modification:
-- 1. In Notepad, open the Assignment07-03.txt file in the Chapter07 folder, and review the
-- package code.
-- 2. Modify the package code to add to the BASKET_INFO_PP procedure so that it also returns
-- the name an order is shipped by using the SHIP_NAME_PF function. Make the necessary
-- changes to make the SHIP_NAME_PF function private.
-- 3. Create the package by using the modified code.
CREATE OR REPLACE PACKAGE order_info_pkg IS
 PROCEDURE basket_info_pp
  (p_basket IN NUMBER,
   p_shop OUT NUMBER,
   p_date OUT DATE,
   p_ship_name OUT VARCHAR2); -- Add parameter for shipping name
END;

CREATE OR REPLACE PACKAGE BODY order_info_pkg IS
 FUNCTION ship_name_pf  
   (p_basket IN NUMBER)
   RETURN VARCHAR2
  IS
   lv_name_txt VARCHAR2(25);
 BEGIN
  SELECT shipfirstname||' '||shiplastname
   INTO lv_name_txt
   FROM bb_basket
   WHERE idBasket = p_basket;
  RETURN lv_name_txt;
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 END ship_name_pf;
 PROCEDURE basket_info_pp
  (p_basket IN NUMBER,
   p_shop OUT NUMBER,
   p_date OUT DATE,
   p_ship_name OUT VARCHAR2) -- Add parameter for shipping name
  IS
 BEGIN
   SELECT idshopper, dtordered, ship_name_pf(p_basket) -- Call private function
    INTO p_shop, p_date, p_ship_name
    FROM bb_basket
    WHERE idbasket = p_basket;
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 END basket_info_pp;
END;


-- 4. Create and run an anonymous block that calls the BASKET_INFO_PP procedure and
-- displays the shopper ID, order date, and shipped-to name to check the values returned.
-- Use DBMS_OUTPUT statements to display the values.
