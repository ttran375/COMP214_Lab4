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

-- test procedure and function in block (returns nulls)
DECLARE
  lv_id      NUMBER := 12;
  lv_name    VARCHAR2(25);
  lv_shopper bb_basket.idshopper%type;
  lv_date    bb_basket.dtcreated%type;
BEGIN
 -- test function
  lv_name := order_info_pkg.ship_name_pf(lv_id);
  dbms_output.put_line(lv_id
                       ||' '
                       ||lv_name);
 -- test procedure
  order_info_pkg.basket_info_pp(lv_id, lv_shopper, lv_date);
  dbms_output.put_line(lv_id
                       ||' '
                       ||lv_shopper
                       ||' '
                       ||lv_date);
END;
/

-- test with select - again, prints nothing
SELECT
  lpad(order_info_pkg.ship_name_pf(idbasket), 20) "ship_name_pf on 12"
FROM
  bb_basket
WHERE
  idbasket = 12;

/

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
-- 4. Create and run an anonymous block that calls the BASKET_INFO_PP procedure and
-- displays the shopper ID, order date, and shipped-to name to check the values returned.
-- Use DBMS_OUTPUT statements to display the values.
CREATE OR REPLACE PACKAGE order_info_pkg IS
 -- deleted function
  PROCEDURE basket_info_pp (
    p_basket IN NUMBER,
    p_shop OUT NUMBER,
    p_date OUT DATE,
    p_ship OUT VARCHAR
  ); -- added out variable
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
    p_date OUT DATE,
    p_ship OUT VARCHAR
  ) -- added out variable
  IS
  BEGIN
    SELECT
      idshopper,
      dtordered INTO p_shop,
      p_date
    FROM
      bb_basket
    WHERE
      idbasket = p_basket;
    p_ship := ship_name_pf(p_basket); -- out variable used here
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END basket_info_pp;
END;
/

-- test procedure in block, this time I used basket
-- id 6, so we could actually see a name
DECLARE
  lv_id      NUMBER := 6;
  lv_name    VARCHAR2(25);
  lv_shopper bb_basket.idshopper%type;
  lv_date    bb_basket.dtcreated%type;
BEGIN
 -- test procedure
  order_info_pkg.basket_info_pp(lv_id, lv_shopper, lv_date, lv_name);
  DBMS_OUTPUT.PUT_LINE(lv_id
                       ||' '
                       ||lv_shopper
                       ||' '
                       ||lv_date
                       ||' '
                       ||lv_name);
END;
/

-- Assignment 7-4: Using Packaged Variables
-- In this assignment, you create a package that uses packaged variables to assist in the user
-- logon process. When a returning shopper logs on, the username and password entered need
-- to be verified against the database. In addition, two values need to be stored in packaged
-- variables for reference during the user session: the shopper ID and the first three digits of
-- the shopper’s zip code (used for regional advertisements displayed on the site).
-- 1. Create a function that accepts a username and password as arguments and verifies these
-- values against the database for a match. If a match is found, return the value Y. Set the
-- value of the variable holding the return value to N. Include a NO_DATA_FOUND exception
-- handler to display a message that the logon values are invalid.
-- 2. Use an anonymous block to test the procedure, using the username gma1 and the
-- password goofy.
-- 3. Now place the function in a package, and add code to create and populate the packaged
-- variables specified earlier. Name the package LOGIN_PKG.
-- 4. Use an anonymous block to test the packaged procedure, using the username gma1 and
-- the password goofy to verify that the procedure works correctly.
-- 5. Use DBMS_OUTPUT statements in an anonymous block to display the values stored in the
-- packaged variables.
-- create the function
CREATE OR REPLACE FUNCTION verify_user (
  usernm IN VARCHAR2,
  passwd IN VARCHAR2
) RETURN CHAR IS
  temp_user bb_shopper.username%type;
  confirm   CHAR(1) := 'N';
BEGIN -- if this select succeed, we can return Y
  SELECT
    username INTO temp_user
  FROM
    bb_shopper
  WHERE
    password = passwd;
  confirm := 'Y';
  RETURN confirm;
EXCEPTION -- if it fails, return N
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('logon values are invalid');
END;
/

-- test w/ host variables
variable g_ck char(1);

BEGIN
  :g_ck := verify_user('gma1', 'goofy');
END;
/

-- it worked!
print g_ck

/

-- make it a package this time
CREATE OR REPLACE PACKAGE login_pckg IS

  FUNCTION verify_user (
    usernm IN VARCHAR2,
    passwd IN VARCHAR2
  ) RETURN CHAR;
END;
/

-- body of the package
CREATE OR REPLACE PACKAGE BODY login_pckg IS

  FUNCTION verify_user (
    usernm IN VARCHAR2, -- everything in the function is the same
    passwd IN VARCHAR2
  ) RETURN CHAR IS
    temp_user bb_shopper.username%type;
    confirm   CHAR(1) := 'N';
  BEGIN
    SELECT
      username INTO temp_user
    FROM
      bb_shopper
    WHERE
      password = passwd;
    confirm := 'Y';
    RETURN confirm;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('logon values are invalid');
  END verify_user;
END;
/

-- host variable
variable g_ck char(1);

-- test, asignment and output in one block for convenience
BEGIN
  :g_ck := login_pckg.verify_user('gma1', 'goofy');
  DBMS_OUTPUT.PUT_LINE(:g_ck); -- it worked!
END;
/

-- Assignment 7-5: Overloading Packaged Procedures
-- In this assignment, you create packaged procedures to retrieve shopper information.
-- Brewbean’s is adding an application page where customer service agents can retrieve shopper
-- information by using shopper ID or last name. Create a package named SHOP_QUERY_PKG
-- containing overloaded procedures to perform these lookups. They should return the shopper’s
-- name, city, state, phone number, and e-mail address. Test the package twice. First, call the
-- procedure with shopper ID 23, and then call it with the last name Ratman. Both test values refer
-- to the same shopper, so they should return the same shopper information.
CREATE OR REPLACE PACKAGE shop_query_pkg IS
 -- first overloaded procedure, takes id
  PROCEDURE retrieve_shopper (
    lv_id IN bb_shopper.idshopper%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  );
 -- second overloaded procedure, takes last name
  PROCEDURE retrieve_shopper (
    lv_last IN bb_shopper.lastname%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  );
END;
/

CREATE OR REPLACE PACKAGE BODY shop_query_pkg IS
 -- first overloaded procedure, takes id
  PROCEDURE retrieve_shopper (
    lv_id IN bb_shopper.idshopper%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  ) IS
  BEGIN -- this is almost the same as 7-1
    SELECT
      firstname
      ||' '
      ||lastname,
      city,
      state,
      phone INTO lv_name,
      lv_city,
      lv_state,
      lv_phone
    FROM
      bb_shopper
    WHERE
      idshopper = lv_id;
  END retrieve_shopper;
 -- second overloaded procedure, takes last name
  PROCEDURE retrieve_shopper (
    lv_last IN bb_shopper.lastname%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  ) IS
  BEGIN -- again same as 7-1
    SELECT
      firstname
      ||' '
      ||lastname,
      city,
      state,
      phone INTO lv_name,
      lv_city,
      lv_state,
      lv_phone
    FROM
      bb_shopper
    WHERE
      lastname = lv_last;
  END retrieve_shopper;
END;
/

-- test procedure in block shopper id 23, Ratman
DECLARE
  lv_id    NUMBER := 23;
  lv_last  bb_shopper.lastname%type := 'Ratman';
  lv_name  VARCHAR2(25);
  lv_city  bb_shopper.city%type;
  lv_state bb_shopper.state%type;
  lv_phone bb_shopper.phone%type;
BEGIN
 -- test procedure w/ id
  shop_query_pkg.retrieve_shopper(lv_id, lv_name, lv_city, lv_state, lv_phone);
  DBMS_OUTPUT.PUT_LINE(lv_name
                       ||' '
                       ||lv_city
                       ||' '
                       ||lv_state
                       ||' '
                       ||lv_phone);
 -- test procedure w/ last name
  shop_query_pkg.retrieve_shopper(lv_last, lv_name, lv_city, lv_state, lv_phone);
  DBMS_OUTPUT.PUT_LINE(lv_name
                       ||' '
                       ||lv_city
                       ||' '
                       ||lv_state
                       ||' '
                       ||lv_phone);
END;
/

-- Assignment 7-6: Creating a Package with Only a Specification
-- In this assignment, you create a package consisting of only a specification. The Brewbean’s
-- lead programmer has noticed that only a few states require Internet sales tax, and the rates
-- don’t change often. Create a package named TAX_RATE_PKG to hold the following tax rates in
-- packaged variables for reference: pv_tax_nc = .035, pv_tax_tx = .05, and pv_tax_tn = .02.
-- Code the variables to prevent the rates from being modified. Use an anonymous block with
-- DBMS_OUTPUT statements to display the value of each packaged variable.
-- create a reference package w/ no body
CREATE OR REPLACE PACKAGE tax_rate_pkg IS
  pv_tax_nc CONSTANT NUMBER := .035; -- all variables are constants
  pv_tax_tx CONSTANT NUMBER := .05;
  pv_tax_tn CONSTANT NUMBER := .02;
END;
/

-- test our body-less package by printing the variables
BEGIN
  DBMS_OUTPUT.PUT_LINE(tax_rate_pkg.pv_tax_nc);
  DBMS_OUTPUT.PUT_LINE(tax_rate_pkg.pv_tax_tx);
  DBMS_OUTPUT.PUT_LINE(tax_rate_pkg.pv_tax_tn);
END;
/

-- Assignment 7-7: Using a Cursor in a Package
-- In this assignment, you work with the sales tax computation because the Brewbean’s lead
-- programmer expects the rates and states applying the tax to undergo some changes. The tax
-- rates are currently stored in packaged variables but need to be more dynamic to handle the
-- expected changes. The lead programmer has asked you to develop a package that holds the
-- tax rates by state in a packaged cursor. The BB_TAX table is updated as needed to reflect
-- which states are applying sales tax and at what rates. This package should contain a function
-- that can receive a two-character state abbreviation (the shopper’s state) as an argument, and it
-- must be able to find a match in the cursor and return the correct tax rate. Use an anonymous
-- block to test the function with the state value NC.
-- create a tax package
CREATE OR REPLACE PACKAGE tax_rate_pkg IS
 -- spec a cursor to hold state and tax rate
  CURSOR cur_tax IS
  SELECT
    taxrate,
    state
  FROM
    bb_tax;
 -- spec a functionto get tax rate
  FUNCTION get_tax (
    pv_state IN bb_tax.state%type
  ) RETURN bb_tax.taxrate%type;
END;
/

-- create a tax package body
CREATE OR REPLACE PACKAGE BODY tax_rate_pkg IS
 -- define our function
  FUNCTION get_tax (
    pv_state IN bb_tax.state%type
  ) RETURN bb_tax.taxrate%type IS
 -- we need a holding variable for the tax rate
    pv_tax bb_tax.taxrate%type := 0.00;
  BEGIN -- use cursor for loop to find state and rate
    FOR rec_tax IN cur_tax LOOP
      IF rec_tax.state = pv_state THEN
        pv_tax := rec_tax.taxrate;
      END IF;
    END LOOP;
 -- return the rate
    RETURN pv_tax;
  END get_tax;
END;
/

-- test our package with NC
BEGIN
  DBMS_OUTPUT.PUT_LINE('NC'
                       ||' '
                       ||tax_rate_pkg.get_tax('NC'));
END;
/

-- Assignment 7-8: Using a One-Time-Only Procedure in a Package
-- The Brewbean’s application currently contains a package used in the shopper logon process.
-- However, one of the developers wants to be able to reference the time users log on to
-- determine when the session should be timed out and entries rolled back. Modify the
-- LOGIN_PKG package (in the Assignment07-08.txt file in the Chapter07 folder). Use a
-- one-time-only procedure to populate a packaged variable with the date and time of user
-- logons. Use an anonymous block to verify that the one-time-only procedure works and
-- populates the packaged variable.
CREATE OR REPLACE PACKAGE login_pkg IS
  pv_login_time timestamp; -- declare variable to hold timestamp
  pv_id_num     NUMBER(3);

  FUNCTION login_ck_pf (
    p_user IN VARCHAR2,
    p_pass IN VARCHAR2
  ) RETURN CHAR;
END;
/

CREATE OR REPLACE PACKAGE BODY login_pkg IS

  FUNCTION login_ck_pf (
    p_user IN VARCHAR2,
    p_pass IN VARCHAR2
  ) RETURN CHAR IS
    lv_ck_txt CHAR(1) := 'N';
    lv_id_num NUMBER(5);
  BEGIN
    SELECT
      idShopper INTO lv_id_num
    FROM
      bb_shopper
    WHERE
      username = p_user
      AND password = p_pass;
    lv_ck_txt := 'Y';
    pv_id_num := lv_id_num;
    RETURN lv_ck_txt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN lv_ck_txt;
  END login_ck_pf; -- get the timestamp when login is called
BEGIN
  SELECT
    systimestamp INTO pv_login_time
  FROM
    dual;
END;
/

-- anonymous block for testing
DECLARE
 -- a few local variables to hold needed data
  lv_user   bb_shopper.username%type := 'Crackj';
  lv_passwd bb_shopper.password%type := 'flyby';
  lv_login  CHAR := 'N';
BEGIN
 -- call the login function
  lv_login := login_pkg.login_ck_pf(lv_user, lv_passwd);
 -- print confirmation that we logged in and the time/date
  DBMS_OUTPUT.PUT_LINE(lv_login
                       ||'   '
                       ||login_pkg.pv_login_time);
END;
/

-- Assignment 7-9: Creating a Package for Pledges
-- Create a package named PLEDGE_PKG that includes two functions for determining dates of
-- pledge payments. Use or create the functions described in Chapter 6 for Assignments 6-12 and
-- 6-13, using the names DD_PAYDATE1_PF and DD_PAYEND_PF for these packaged functions.
-- Test both functions with a specific pledge ID, using an anonymous block. Then test both
-- functions in a single query showing all pledges and associated payment dates.
CREATE OR REPLACE PACKAGE PLEDGE_PKG AS
 -- Function to calculate the first payment date for a given pledge.
  FUNCTION DD_PAYDATE1_PF(
    idPledge IN NUMBER
  ) RETURN DATE;
 -- Function to calculate the end payment date for a given pledge.
  FUNCTION DD_PAYEND_PF(
    idPledge IN NUMBER
  ) RETURN DATE;
END PLEDGE_PKG;
/

CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG AS

  FUNCTION DD_PAYDATE1_PF(
    idPledge IN NUMBER
  ) RETURN DATE IS
    v_paydate DATE;
  BEGIN
 -- Dummy implementation, replace with actual logic
    SELECT
      MIN(Paydate) INTO v_paydate
    FROM
      DD_PAYMENT
    WHERE
      idPledge = idPledge;
    RETURN v_paydate;
  END DD_PAYDATE1_PF;

  FUNCTION DD_PAYEND_PF(
    idPledge IN NUMBER
  ) RETURN DATE IS
    v_enddate DATE;
  BEGIN
 -- Dummy implementation, replace with actual logic
    SELECT
      MAX(Paydate) INTO v_enddate
    FROM
      DD_PAYMENT
    WHERE
      idPledge = idPledge;
    RETURN v_enddate;
  END DD_PAYEND_PF;
END PLEDGE_PKG;
/

BEGIN
 -- Replace 101 with your specific pledge ID
  DBMS_OUTPUT.PUT_LINE('First Payment Date: '
                       || PLEDGE_PKG.DD_PAYDATE1_PF(101));
  DBMS_OUTPUT.PUT_LINE('End Payment Date: '
                       || PLEDGE_PKG.DD_PAYEND_PF(101));
END;
/

SELECT
  p.idPledge,
  PLEDGE_PKG.DD_PAYDATE1_PF(p.idPledge) AS First_Payment_Date,
  PLEDGE_PKG.DD_PAYEND_PF(p.idPledge)   AS Last_Payment_Date
FROM
  DD_PLEDGE p;
