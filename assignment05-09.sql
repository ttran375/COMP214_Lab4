-- Assignment 5-9: Creating a Logon Procedure
-- The home page of the Brewbean’s Web site has an option for members to log on with their IDs
-- and passwords. Develop a procedure named MEMBER_CK_SP that accepts the ID and password
-- as inputs, checks whether they make up a valid logon, and returns the member name and cookie
-- value. The name should be returned as a single text string containing the first and last name.
-- The head developer wants the number of parameters minimized so that the same
-- parameter is used to accept the password and return the name value. Also, if the user doesn’t
-- enter a valid username and password, return the value INVALID in a parameter named
-- p_check. Test the procedure using a valid logon first, with the username rat55 and password
-- kile. Then try it with an invalid logon by changing the username to rat.

CREATE OR REPLACE PROCEDURE MEMBER_CK_SP (
  p_username IN VARCHAR2,
  p_password IN VARCHAR2,
  p_check OUT VARCHAR2,
  p_member_name OUT VARCHAR2,
  p_cookie OUT NUMBER
) IS
  v_member_name VARCHAR2(50);
BEGIN
 -- Check if the username and password are valid
  SELECT
    FirstName
    || ' '
    || LastName INTO v_member_name
  FROM
    bb_shopper
  WHERE
    UserName = p_username
    AND Password = p_password;
 -- If a member with the provided username and password is found
 -- Set p_check to 'VALID', return member name and cookie value
  p_check := 'VALID';
  p_member_name := v_member_name;
  p_cookie := dbms_random.value(1, 9999); -- Generating a random cookie value
EXCEPTION
 -- If no member is found or an exception occurs, set p_check to 'INVALID'
  WHEN NO_DATA_FOUND THEN
    p_check := 'INVALID';
    p_member_name := NULL;
    p_cookie := NULL;
  WHEN OTHERS THEN
    p_check := 'INVALID';
    p_member_name := NULL;
    p_cookie := NULL;
END MEMBER_CK_SP;
/

DECLARE
  v_check       VARCHAR2(10);
  v_member_name VARCHAR2(50);
  v_cookie      NUMBER;
BEGIN
 -- Testing with valid logon credentials
  MEMBER_CK_SP('rat55', 'kile', v_check, v_member_name, v_cookie);
  DBMS_OUTPUT.PUT_LINE('Check: '
                       || v_check);
  IF v_check = 'VALID' THEN
    DBMS_OUTPUT.PUT_LINE('Member Name: '
                         || v_member_name);
    DBMS_OUTPUT.PUT_LINE('Cookie: '
                         || v_cookie);
  END IF;
 -- Testing with invalid logon credentials
  MEMBER_CK_SP('rat', 'password', v_check, v_member_name, v_cookie);
  DBMS_OUTPUT.PUT_LINE('Check: '
                       || v_check);
END;
