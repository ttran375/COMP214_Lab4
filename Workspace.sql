-- Assignment 7-8: Using a One-Time-Only Procedure in a Package
-- The Brewbean’s application currently contains a package used in the shopper logon process.
-- However, one of the developers wants to be able to reference the time users log on to
-- determine when the session should be timed out and entries rolled back. Modify the
-- LOGIN_PKG package (in the Assignment07-08.txt file in the Chapter07 folder). Use a
-- one-time-only procedure to populate a packaged variable with the date and time of user
-- logons. Use an anonymous block to verify that the one-time-only procedure works and
-- populates the packaged variable.

CREATE OR REPLACE PACKAGE login_pkg IS
  -- Declare variable to hold timestamp
  pv_login_time timestamp;
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
  END login_ck_pf;
 -- get the timestamp when login is called
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
  dbms_output.put_line(lv_login
                       ||'   '
                       ||login_pkg.pv_login_time);
END;
/
