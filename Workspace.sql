-- Assignment 7-10: Adding a Pledge Display Procedure to the Package
-- Modify the package created in Assignment 7-9 as follows:
-- • Add a procedure named DD_PLIST_PP that displays the donor name and all
-- associated pledges (including pledge ID, first payment due date, and last payment
-- due date). A donor ID is the input value for the procedure.
-- • Make the procedure public and the two functions private.
-- Test the procedure with an anonymous block.
CREATE OR REPLACE PACKAGE PLEDGE_PKG AS
  -- Procedure to display donor name and all associated pledges
  PROCEDURE DD_PLIST_PP(idDonor IN NUMBER);
END PLEDGE_PKG;
/

CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG AS

  -- Private function to calculate the first payment date for a given pledge.
  FUNCTION DD_PAYDATE1_PF(idPledge IN NUMBER) RETURN DATE IS
    v_paydate DATE;
  BEGIN
    -- Implement the logic as per your assignment requirements
    SELECT MIN(Paydate) INTO v_paydate
    FROM DD_PAYMENT
    WHERE idPledge = idPledge;
    RETURN v_paydate;
  END DD_PAYDATE1_PF;

  -- Private function to calculate the end payment date for a given pledge.
  FUNCTION DD_PAYEND_PF(idPledge IN NUMBER) RETURN DATE IS
    v_enddate DATE;
  BEGIN
    -- Implement the logic as per your assignment requirements
    SELECT MAX(Paydate) INTO v_enddate
    FROM DD_PAYMENT
    WHERE idPledge = idPledge;
    RETURN v_enddate;
  END DD_PAYEND_PF;

  -- Public procedure as specified
  PROCEDURE DD_PLIST_PP(idDonor IN NUMBER) IS
  BEGIN
    FOR r IN (SELECT d.Firstname || ' ' || d.Lastname AS DonorName, p.idPledge, DD_PAYDATE1_PF(p.idPledge) AS FirstPaymentDate, DD_PAYEND_PF(p.idPledge) AS LastPaymentDate
              FROM DD_DONOR d
              JOIN DD_PLEDGE p ON d.idDonor = p.idDonor
              WHERE d.idDonor = idDonor) LOOP
      DBMS_OUTPUT.PUT_LINE('Donor: ' || r.DonorName || ', Pledge ID: ' || r.idPledge || ', First Payment Date: ' || r.FirstPaymentDate || ', Last Payment Date: ' || r.LastPaymentDate);
    END LOOP;
  END DD_PLIST_PP;

END PLEDGE_PKG;
/

BEGIN
  PLEDGE_PKG.DD_PLIST_PP(301);
END;
/
