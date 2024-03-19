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
  dbms_output.put_line(:g_ck); -- it worked!
END;
/
