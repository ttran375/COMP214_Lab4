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
