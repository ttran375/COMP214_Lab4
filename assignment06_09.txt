-- Assignment 6-9: Determining the Monthly Payment Amount
-- Create a function named DD_MTHPAY_SF that calculates and returns the monthly payment
-- amount for donor pledges paid on a monthly basis. Input values should be the number of
-- monthly payments and the pledge amount. Use the function in an anonymous PL/SQL block
-- to show its use with the following pledge information: pledge amount = $240 and monthly
-- payments = 12. Also, use the function in an SQL statement that displays information for all
-- donor pledges in the database on a monthly payment plan.
CREATE OR REPLACE FUNCTION DD_MTHPAY_SF(
  lv_paymonths IN NUMBER,
  lv_pledgeamt IN NUMBER
) RETURN NUMBER IS
  lv_monthly_payment NUMBER;
BEGIN
  lv_monthly_payment := lv_pledgeamt / lv_paymonths;
  RETURN lv_monthly_payment;
END DD_MTHPAY_SF;
/

-- Anonymous PL/SQL block demonstrating the use of the function
DECLARE
  lv_pledge_amount          NUMBER := 240;
  lv_monthly_payments       NUMBER := 12;
  lv_monthly_payment_amount NUMBER;
BEGIN
  lv_monthly_payment_amount := DD_MTHPAY_SF(lv_monthly_payments, lv_pledge_amount);
  DBMS_OUTPUT.PUT_LINE('Monthly payment amount for the pledge: $'
                       || lv_monthly_payment_amount);
END;
/

-- SQL statement to display information for all donor pledges in the database on a monthly payment plan
SELECT
  dp.idPledge,
  dp.idDonor,
  d.Firstname
  || ' '
  || d.Lastname                            AS Donor_Name,
  dp.Pledgeamt                             AS Pledge_Amount,
  dp.paymonths                             AS Payment_Months,
  DD_MTHPAY_SF(dp.paymonths, dp.Pledgeamt) AS Monthly_Payment_Amount
FROM
  dd_pledge dp
  JOIN dd_donor d
  ON dp.idDonor = d.idDonor
WHERE
  dp.paymonths > 0;
