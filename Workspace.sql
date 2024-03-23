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

-- Create a function that accepts a username and password as arguments  .
CREATE OR REPLACE FUNCTION verify_user (
  usernm IN VARCHAR2,
  passwd IN VARCHAR2
) RETURN CHAR IS
  temp_user bb_shopper.username%type;
  -- Set the value of the variable holding the return value to N
  confirm   CHAR(1) := 'N';
-- If a match is found, return the value Y.
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
    -- Include a NO_DATA_FOUND exception handler to display a message that the logon values are invalid.
    DBMS_OUTPUT.PUT_LINE('The logon values are invalid.');
END;
/

-- Use an anonymous block to test the procedure, using the username gma1 and the password goofy
DECLARE
  result CHAR(1);
BEGIN
  result := verify_user('gma1', 'goofy');
  IF result = 'Y' THEN
    DBMS_OUTPUT.PUT_LINE('Login successful!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Login failed!');
  END IF;
END;
/

-- Now place the function in a package, name the package LOGIN_PKG
CREATE OR REPLACE PACKAGE LOGIN_PKG AS
  -- Packaged variables
  shopper_id      bb_shopper.shopper_id%TYPE;
  zip_code_prefix bb_shopper.zip_code%TYPE(3);
  -- Function to verify user
  FUNCTION verify_user (
    usernm IN VARCHAR2,
    passwd IN VARCHAR2
  ) RETURN CHAR;
END LOGIN_PKG;
/

CREATE OR REPLACE PACKAGE BODY LOGIN_PKG AS
 -- Function to verify user
  FUNCTION verify_user (
    usernm IN VARCHAR2,
    passwd IN VARCHAR2
  ) RETURN CHAR IS
    temp_user bb_shopper.username%TYPE;
    confirm   CHAR(1) := 'N';
  BEGIN
    SELECT
      username INTO temp_user
    FROM
      bb_shopper
    WHERE
      password = passwd;
    -- If a match is found, set confirmation to Y
    confirm := 'Y';
    -- Store shopper ID and zip code prefix in packaged variables
    SELECT
      shopper_id,
      SUBSTR(zip_code, 1, 3) INTO shopper_id,
      zip_code_prefix
    FROM
      bb_shopper
    WHERE
      username = usernm;
    RETURN confirm;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Handle invalid logon values
      DBMS_OUTPUT.PUT_LINE('The logon values are invalid.');
  END verify_user;
END LOGIN_PKG;
/

-- Use an anonymous block to test the packaged procedure
DECLARE
  result CHAR(1);
BEGIN
  result := LOGIN_PKG.verify_user('gma1', 'goofy');
  IF result = 'Y' THEN
    DBMS_OUTPUT.PUT_LINE('Login successful!');
    -- Use DBMS_OUTPUT statements in an anonymous block to display the values stored in the packaged variables
    DBMS_OUTPUT.PUT_LINE('Shopper ID: '
                         || LOGIN_PKG.shopper_id);
    DBMS_OUTPUT.PUT_LINE('Zip Code Prefix: '
                         || LOGIN_PKG.zip_code_prefix);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Login failed!');
  END IF;
END;
/
