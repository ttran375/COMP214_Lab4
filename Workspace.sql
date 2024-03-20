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
