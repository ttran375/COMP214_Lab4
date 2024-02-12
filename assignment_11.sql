-- Assignment 3-11: Retrieving and Displaying Pledge Data
-- Create a PL/SQL block to retrieve and display data for all pledges made in a specified month.
-- One row of output should be displayed for each pledge. Include the following in each row
-- of output:
-- • Pledge ID, donor ID, and pledge amount
-- • If the pledge is being paid in a lump sum, display “Lump Sum.”
-- • If the pledge is being paid in monthly payments, display “Monthly - #” (with the #
-- representing the number of months for payment).
-- • The list should be sorted to display all lump sum pledges first.
DECLARE
  lv_month   NUMBER := 1; -- replace with your month number
  lv_year    NUMBER := 2022; -- replace with your year
  CURSOR pledge_cur IS
  SELECT
    pledge_id,
    donor_id,
    pledge_amount,
    payment_type,
    payment_months
  FROM
    pledges
  WHERE
    EXTRACT(MONTH FROM pledge_date) = lv_month
    AND EXTRACT(YEAR FROM pledge_date) = lv_year
  ORDER BY
    CASE
      WHEN payment_type = 'Lump Sum' THEN
        1
      ELSE
        2 END;
  pledge_rec pledge_cur%ROWTYPE;
BEGIN
  OPEN pledge_cur;
  LOOP
    FETCH pledge_cur INTO pledge_rec;
    EXIT WHEN pledge_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || pledge_rec.pledge_id);
    DBMS_OUTPUT.PUT_LINE('Donor ID: '
                         || pledge_rec.donor_id);
    DBMS_OUTPUT.PUT_LINE('Pledge Amount: '
                         || pledge_rec.pledge_amount);
    IF pledge_rec.payment_type = 'Lump Sum' THEN
      DBMS_OUTPUT.PUT_LINE('Payment Type: Lump Sum');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Payment Type: Monthly - '
                           || pledge_rec.payment_months);
    END IF;

    DBMS_OUTPUT.PUT_LINE('-----');
  END LOOP;

  CLOSE pledge_cur;
END;
