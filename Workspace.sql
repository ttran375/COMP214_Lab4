-- Assignment 7-5: Overloading Packaged Procedures
-- In this assignment, you create packaged procedures to retrieve shopper information.
-- Brewbean’s is adding an application page where customer service agents can retrieve shopper
-- information by using shopper ID or last name. Create a package named SHOP_QUERY_PKG
-- containing overloaded procedures to perform these lookups. They should return the shopper’s
-- name, city, state, phone number, and e-mail address. Test the package twice. First, call the
-- procedure with shopper ID 23, and then call it with the last name Ratman. Both test values refer
-- to the same shopper, so they should return the same shopper information.

-- Create a package named SHOP_QUERY_PKG
CREATE OR REPLACE PACKAGE shop_query_pkg IS
 -- Containing overloaded procedure takes id
  PROCEDURE retrieve_shopper (
    lv_id IN bb_shopper.idshopper%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  );
 -- Containing overloaded procedure takes lastname
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
