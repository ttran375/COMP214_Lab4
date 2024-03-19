-- Assignment 6-10: Calculating the Total Project Pledge Amount
-- Create a function named DD_PROJTOT_SF that determines the total pledge amount for a project.
-- Use the function in an SQL statement that lists all projects, displaying project ID, project name,
-- and project pledge total amount. Format the pledge total to display zero if no pledges have been
-- made so far, and have it show a dollar sign, comma, and two decimal places for dollar values.
CREATE OR REPLACE FUNCTION DD_PROJTOT_SF(
  lv_project_id IN NUMBER
) RETURN NUMBER IS
  lv_total_pledge_amount NUMBER;
BEGIN
  SELECT
    NVL(SUM(Pledgeamt), 0) INTO lv_total_pledge_amount
  FROM
    dd_pledge
  WHERE
    idProj = lv_project_id;
  RETURN lv_total_pledge_amount;
END DD_PROJTOT_SF;
/

SELECT
  idProj,
  Projname,
  TO_CHAR(DD_PROJTOT_SF(idProj), '$999,999,999.99') AS Project_Pledge_Total
FROM
  dd_project;

-- Assignment 6-11: Identifying Pledge Status
-- The DoGood Donor organization decided to reduce SQL join activity in its application by
-- eliminating the DD_STATUS table and replacing it with a function that returns a status description
-- based on the status ID value. Create this function and name it DD_PLSTAT_SF. Use the function
-- in an SQL statement that displays the pledge ID, pledge date, and pledge status for all pledges.
-- Also, use it in an SQL statement that displays the same values but for only a specified pledge.
CREATE OR REPLACE FUNCTION DD_PLSTAT_SF(
  lv_status_id IN NUMBER
) RETURN VARCHAR2 IS
  lv_status_desc VARCHAR2(15);
BEGIN
  CASE lv_status_id
    WHEN 10 THEN
      lv_status_desc := 'Open';
    WHEN 20 THEN
      lv_status_desc := 'Complete';
    WHEN 30 THEN
      lv_status_desc := 'Overdue';
    WHEN 40 THEN
      lv_status_desc := 'Closed';
    WHEN 50 THEN
      lv_status_desc := 'Hold';
    ELSE
      lv_status_desc := 'Unknown';
  END CASE;

  RETURN lv_status_desc;
END DD_PLSTAT_SF;
/

SELECT
  idPledge,
  Pledgedate,
  DD_PLSTAT_SF(idStatus) AS Pledge_Status
FROM
  dd_pledge;

SELECT
  idPledge,
  Pledgedate,
  DD_PLSTAT_SF(idStatus) AS Pledge_Status
FROM
  dd_pledge
WHERE
  idPledge = :specified_pledge_id;

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
