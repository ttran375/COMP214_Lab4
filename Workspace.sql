-- Assignment 7-10: Adding a Pledge Display Procedure to the Package
-- Modify the package created in Assignment 7-9 as follows:
-- • Add a procedure named DD_PLIST_PP that displays the donor name and all
-- associated pledges (including pledge ID, first payment due date, and last payment
-- due date). A donor ID is the input value for the procedure.
-- • Make the procedure public and the two functions private.
-- Test the procedure with an anonymous block.

CREATE OR REPLACE PACKAGE PLEDGE_PKG AS
  -- Procedure to display donor name and all associated pledges. A donor ID is the input value for the procedure
  PROCEDURE DD_PLIST_PP(
    idDonor IN NUMBER
  );
END PLEDGE_PKG;
/

CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG AS
  -- Determine a Pledge’s First Payment Date
  FUNCTION DD_PAYDATE1_PF(
    idPledge IN NUMBER
  ) RETURN DATE IS
    lv_paydate DATE;
  BEGIN
    SELECT
      MIN(Paydate) INTO lv_paydate
    FROM
      DD_PAYMENT
    WHERE
      idPledge = idPledge;
    RETURN lv_paydate;
  END DD_PAYDATE1_PF;
  -- Determining a Pledge’s Final Payment Date
  FUNCTION DD_PAYEND_PF(
    idPledge IN NUMBER
  ) RETURN DATE IS
    v_enddate DATE;
  BEGIN
    SELECT
      MAX(Paydate) INTO v_enddate
    FROM
      DD_PAYMENT
    WHERE
      idPledge = idPledge;
    RETURN v_enddate;
  END DD_PAYEND_PF;
  PROCEDURE DD_PLIST_PP(
    idDonor IN NUMBER
  ) IS
  BEGIN
    FOR r IN (
      SELECT
        d.Firstname
        || ' '
        || d.Lastname              AS DonorName,
        p.idPledge,
        DD_PAYDATE1_PF(p.idPledge) AS FirstPaymentDate,
        DD_PAYEND_PF(p.idPledge)   AS LastPaymentDate
      FROM
        DD_DONOR  d
        JOIN DD_PLEDGE p
        ON d.idDonor = p.idDonor
      WHERE
        d.idDonor = idDonor
    ) LOOP
      DBMS_OUTPUT.PUT_LINE('Donor: '
                           || r.DonorName
                           || ', Pledge ID: '
                           || r.idPledge
                           || ', First Payment Date: '
                           || r.FirstPaymentDate
                           || ', Last Payment Date: '
                           || r.LastPaymentDate);
    END LOOP;
  END DD_PLIST_PP;
END PLEDGE_PKG;
/

BEGIN
  PLEDGE_PKG.DD_PLIST_PP(301);
END;
/
