CREATE OR REPLACE FUNCTION DD_MTHPAY_SF(
  v_paymonths IN NUMBER,
  v_pledgeamt IN NUMBER
) RETURN NUMBER IS
  v_monthly_payment NUMBER;
BEGIN
  v_monthly_payment := v_pledgeamt / v_paymonths;
  RETURN v_monthly_payment;
END DD_MTHPAY_SF;
/

-- Anonymous PL/SQL block demonstrating the use of the function
DECLARE
  v_pledge_amount          NUMBER := 240;
  v_monthly_payments       NUMBER := 12;
  v_monthly_payment_amount NUMBER;
BEGIN
  v_monthly_payment_amount := DD_MTHPAY_SF(v_monthly_payments, v_pledge_amount);
  DBMS_OUTPUT.PUT_LINE('Monthly payment amount for the pledge: $'
                       || v_monthly_payment_amount);
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
