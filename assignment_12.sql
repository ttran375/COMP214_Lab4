-- Assignment 3-12: Retrieving a Specific Pledge
-- Create a PL/SQL block to retrieve and display information for a specific pledge. Display the
-- pledge ID, donor ID, pledge amount, total paid so far, and the difference between the pledged
-- amount and total paid amount.
DECLARE
  v_pledge_id   NUMBER := 102; -- Replace with the desired pledge ID
  v_pledge_info DD_Pledge%ROWTYPE;
  v_total_paid  NUMBER := 0;
BEGIN
 -- Retrieve pledge information
  SELECT
    * INTO v_pledge_info
  FROM
    DD_Pledge
  WHERE
    idPledge = v_pledge_id;
 -- Calculate total paid for the pledge
  SELECT
    NVL(SUM(Payamt), 0) INTO v_total_paid
  FROM
    DD_Payment
  WHERE
    idPledge = v_pledge_id;
 -- Display pledge details
  DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                       || v_pledge_info.idPledge
                       || ', Donor ID: '
                       || v_pledge_info.idDonor
                       || ', Pledge Amount: '
                       || v_pledge_info.Pledgeamt
                       || ', Total Paid: '
                       || v_total_paid
                       || ', Remaining Amount: '
                       || (v_pledge_info.Pledgeamt - v_total_paid));
END;
