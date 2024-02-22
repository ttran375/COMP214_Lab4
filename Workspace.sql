CREATE OR REPLACE PROCEDURE MEMBER_CK_SP (
  p_username IN VARCHAR2,
  p_password IN OUT VARCHAR2,
  p_name OUT VARCHAR2,
  p_check OUT VARCHAR2
) AS
  v_member_name VARCHAR2(100);
BEGIN
 -- Check if the username and password are valid
  SELECT
    first_name
    || ' '
    || last_name INTO v_member_name
  FROM
    BB_MEMBER
  WHERE
    username = p_username
    AND password = p_password;
 -- If a record is found, the username and password are valid
  IF v_member_name IS NOT NULL THEN
    p_name := v_member_name;
    p_check := 'VALID';
 -- Generate and return the cookie value (for simplicity, a placeholder is used here)
    p_password := 'cookie_value_placeholder';
  ELSE
 -- If no record is found, the username and password are invalid
    p_check := 'INVALID';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
 -- If no record is found, the username and password are invalid
    p_check := 'INVALID';
  WHEN OTHERS THEN
 -- Handle other exceptions
    p_check := 'ERROR: '
               || SQLERRM;
END;
/

DECLARE
  v_password VARCHAR2(100) := 'kile'; -- Valid password
  v_name     VARCHAR2(100);
  v_check    VARCHAR2(100);
BEGIN
  MEMBER_CK_SP('rat55', v_password, v_name, v_check);
  DBMS_OUTPUT.PUT_LINE('Name: '
                       || v_name);
  DBMS_OUTPUT.PUT_LINE('Check: '
                       || v_check);
  DBMS_OUTPUT.PUT_LINE('Cookie Value: '
                       || v_password); -- Placeholder for cookie value
END;
/

DECLARE
  v_password VARCHAR2(100) := 'invalid_password'; -- Invalid password
  v_name     VARCHAR2(100);
  v_check    VARCHAR2(100);
BEGIN
  MEMBER_CK_SP('rat', v_password, v_name, v_check); -- Invalid username
  DBMS_OUTPUT.PUT_LINE('Name: '
                       || v_name);
  DBMS_OUTPUT.PUT_LINE('Check: '
                       || v_check);
  DBMS_OUTPUT.PUT_LINE('Cookie Value: '
                       || v_password); -- Placeholder for cookie value
END;
/
