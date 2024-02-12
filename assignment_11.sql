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
  lv_month VARCHAR2(20) := 'FEB-2013'; -- Specify the desired month here
BEGIN
  FOR pledge_rec IN (
    SELECT
      p.idPledge,
      p.idDonor,
      p.Pledgeamt,
      CASE
        WHEN p.paymonths = 0 THEN
          'Lump Sum'
        ELSE
          'Monthly - '
          || TO_CHAR(p.paymonths)
      END         AS payment_type
    FROM
      DD_Pledge p
    WHERE
      TO_CHAR(TO_DATE(p.Pledgedate, 'DD-MON-YYYY'), 'MON-YYYY') = lv_month
    ORDER BY
      payment_type,
      p.idPledge
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || pledge_rec.idPledge
                         || ', Donor ID: '
                         || pledge_rec.idDonor
                         || ', Pledge Amount: '
                         || pledge_rec.Pledgeamt
                         || ', Payment Type: '
                         || pledge_rec.payment_type);
  END LOOP;
END;
