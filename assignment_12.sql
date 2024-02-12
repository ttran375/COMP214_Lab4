-- Assignment 3-12: Retrieving a Specific Pledge
-- Create a PL/SQL block to retrieve and display information for a specific pledge. Display the
-- pledge ID, donor ID, pledge amount, total paid so far, and the difference between the pledged
-- amount and total paid amount.
DECLARE
  lv_pledge_id   NUMBER := 102; -- Replace with the desired pledge ID
  lv_pledge_info DD_Pledge%ROWTYPE;
  lv_total_paid  NUMBER := 0;
BEGIN
 -- Retrieve pledge information
  SELECT
    * INTO lv_pledge_info
  FROM
    DD_Pledge
  WHERE
    idPledge = lv_pledge_id;
 -- Calculate total paid for the pledge
  SELECT
    NVL(SUM(Payamt), 0) INTO lv_total_paid
  FROM
    DD_Payment
  WHERE
    idPledge = lv_pledge_id;
 -- Display pledge details
  DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                       || lv_pledge_info.idPledge
                       || ', Donor ID: '
                       || lv_pledge_info.idDonor
                       || ', Pledge Amount: '
                       || lv_pledge_info.Pledgeamt
                       || ', Total Paid: '
                       || lv_total_paid
                       || ', Remaining Amount: '
                       || (lv_pledge_info.Pledgeamt - lv_total_paid));
END;
