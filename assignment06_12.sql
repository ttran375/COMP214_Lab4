-- Assignment 6-12: Determining a Pledge’s First Payment Date
-- Create a function named DD_PAYDATE1_SF that determines the first payment due date for a
-- pledge based on pledge ID. The first payment due date is always the first day of the month
-- after the date the pledge was made, even if a pledge is made on the first of a month. Keep in
-- mind that a pledge made in December should reflect a first payment date with the following
-- year. Use the function in an anonymous block.
CREATE OR REPLACE FUNCTION DD_PAYDATE1_SF(
  lv_pledge_id IN NUMBER
) RETURN DATE IS
  lv_pledge_date        DATE;
  lv_first_payment_date DATE;
BEGIN
 -- Get the pledge date for the given pledge ID
  SELECT
    Pledgedate INTO lv_pledge_date
  FROM
    dd_pledge
  WHERE
    idPledge = lv_pledge_id;
 -- Calculate the first payment date
  IF EXTRACT(MONTH FROM lv_pledge_date) = 12 THEN
 -- If pledge made in December, first payment is in January of next year
    lv_first_payment_date := ADD_MONTHS(TRUNC(lv_pledge_date, 'YYYY'), 1);
  ELSE
 -- Otherwise, first payment is in the next month
    lv_first_payment_date := ADD_MONTHS(lv_pledge_date, 1);
  END IF;

  RETURN lv_first_payment_date;
END DD_PAYDATE1_SF;
/

DECLARE
  lv_pledge_id          NUMBER := 104; -- Replace with the desired pledge ID
  lv_first_payment_date DATE;
BEGIN
  lv_first_payment_date := DD_PAYDATE1_SF(lv_pledge_id);
  DBMS_OUTPUT.PUT_LINE('First payment due date for pledge '
                       || lv_pledge_id
                       || ': '
                       || TO_CHAR(lv_first_payment_date, 'DD-MON-YYYY'));
END;
