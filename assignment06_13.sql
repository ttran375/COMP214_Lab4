-- Assignment 6-13: Determining a Pledge’s Final Payment Date
-- Create a function named DD_PAYEND_SF that determines the final payment date for a pledge
-- based on pledge ID. Use the function created in Assignment 6-12 in this new function to help
-- with the task. If the donation pledge indicates a lump sum payment, the final payment date is
-- the same as the first payment date. Use the function in an anonymous block.
CREATE OR REPLACE FUNCTION DD_PAYEND_SF(
  lv_pledge_id IN NUMBER
) RETURN DATE IS
  lv_final_payment_date DATE;
  lv_paymonths          NUMBER;
BEGIN
 -- Get the number of payment months for the given pledge ID
  SELECT
    paymonths INTO lv_paymonths
  FROM
    dd_pledge
  WHERE
    idPledge = lv_pledge_id;
  IF lv_paymonths IS NULL OR lv_paymonths = 0 THEN
 -- If lump sum payment, final payment date is the same as the first payment date
    lv_final_payment_date := DD_PAYDATE1_SF(lv_pledge_id);
  ELSE
 -- Calculate final payment date based on the first payment date and payment months
    lv_final_payment_date := ADD_MONTHS(DD_PAYDATE1_SF(lv_pledge_id), lv_paymonths);
  END IF;

  RETURN lv_final_payment_date;
END DD_PAYEND_SF;
/

DECLARE
  lv_pledge_id          NUMBER := 104; -- Replace with the desired pledge ID
  lv_final_payment_date DATE;
BEGIN
  lv_final_payment_date := DD_PAYEND_SF(lv_pledge_id);
  DBMS_OUTPUT.PUT_LINE('Final payment date for pledge '
                       || lv_pledge_id
                       || ': '
                       || TO_CHAR(lv_final_payment_date, 'DD-MON-YYYY'));
END;
