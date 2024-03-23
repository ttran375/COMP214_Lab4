-- Assignment 7-5: Overloading Packaged Procedures
-- In this assignment, you create packaged procedures to retrieve shopper information.
-- Brewbean’s is adding an application page where customer service agents can retrieve shopper
-- information by using shopper ID or last name. Create a package named SHOP_QUERY_PKG
-- containing overloaded procedures to perform these lookups. They should return the shopper’s
-- name, city, state, phone number, and e-mail address. Test the package twice. First, call the
-- procedure with shopper ID 23, and then call it with the last name Ratman. Both test values refer
-- to the same shopper, so they should return the same shopper information.

CREATE OR REPLACE PACKAGE shop_query_pkg IS
  -- Procedure to retrieve shopper information by shopper ID
  PROCEDURE retrieve_shopper (
    lv_id IN bb_shopper.idshopper%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type,
    lv_email OUT bb_shopper.email%type
  );
  -- Procedure to retrieve shopper information by last name
  PROCEDURE retrieve_shopper (
    lv_last IN bb_shopper.lastname%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type,
    lv_email OUT bb_shopper.email%type
  );
END;
/

CREATE OR REPLACE PACKAGE BODY shop_query_pkg IS
  -- Implementation of retrieve_shopper procedure by shopper ID
  PROCEDURE retrieve_shopper (
    lv_id IN bb_shopper.idshopper%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type,
    lv_email OUT bb_shopper.email%type
  ) IS
  BEGIN
    SELECT
      firstname
      ||' '
      ||lastname,
      city,
      state,
      phone,
      email INTO lv_name,
      lv_city,
      lv_state,
      lv_phone,
      lv_email
    FROM
      bb_shopper
    WHERE
      idshopper = lv_id; -- Filter by shopper ID
  END retrieve_shopper; -- Implementation of retrieve_shopper procedure by last name
  PROCEDURE retrieve_shopper (
    lv_last IN bb_shopper.lastname%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type,
    lv_email OUT bb_shopper.email%type
  ) IS
  BEGIN
    SELECT
      firstname
      ||' '
      ||lastname,
      city,
      state,
      phone,
      email INTO lv_name,
      lv_city,
      lv_state,
      lv_phone,
      lv_email
    FROM
      bb_shopper
    WHERE
      lastname = lv_last; -- Filter by shopper's last name
  END retrieve_shopper;
END;
/

-- Test the package twice
DECLARE
  -- Call the procedure with shopper ID 23
  lv_id    NUMBER := 23;
  -- Call it with the last name Ratman
  lv_last  bb_shopper.lastname%type := 'Ratman';
  lv_name  VARCHAR2(25);
  lv_city  bb_shopper.city%type;
  lv_state bb_shopper.state%type;
  lv_phone bb_shopper.phone%type;
  lv_email bb_shopper.email%type;
BEGIN
 -- Retrieve shopper information by shopper ID
  shop_query_pkg.retrieve_shopper(lv_id, lv_name, lv_city, lv_state, lv_phone, lv_email);
 -- Display shopper information
  dbms_output.put_line(lv_name
                       ||' '
                       ||lv_city
                       ||' '
                       ||lv_state
                       ||' '
                       ||lv_phone
                       ||' '
                       ||lv_email);
 -- Retrieve shopper information by last name
  shop_query_pkg.retrieve_shopper(lv_last, lv_name, lv_city, lv_state, lv_phone, lv_email);
 -- Display shopper information
  dbms_output.put_line(lv_name
                       ||' '
                       ||lv_city
                       ||' '
                       ||lv_state
                       ||' '
                       ||lv_phone
                       ||' '
                       ||lv_email);
END;
/
