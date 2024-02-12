-- Assignment 3-12: Retrieving a Specific Pledge
-- Create a PL/SQL block to retrieve and display information for a specific pledge. Display the
-- pledge ID, donor ID, pledge amount, total paid so far, and the difference between the pledged
-- amount and total paid amount.
DECLARE
  v_pledge_id     NUMBER;
  v_donor_id      NUMBER;
  v_pledge_amount NUMBER;
  v_total_paid    NUMBER;
  v_difference    NUMBER;
BEGIN
 -- Assuming you have the pledge ID, you can assign it to v_pledge_id variable.
 -- For example:
  v_pledge_id := 1;
 -- Retrieve pledge information
  SELECT
    idBasket,
    idShopper,
    SubTotal INTO v_pledge_id,
    v_donor_id,
    v_pledge_amount
  FROM
    bb_basket
  WHERE
    idBasket = v_pledge_id;
 -- Retrieve total paid for the pledge
  SELECT
    SUM(SubTotal) INTO v_total_paid
  FROM
    bb_basket
  WHERE
    idBasket = v_pledge_id;
 -- Calculate the difference between pledge amount and total paid
  v_difference := v_pledge_amount - NVL(v_total_paid, 0);
 -- Display pledge information
  DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                       || v_pledge_id);
  DBMS_OUTPUT.PUT_LINE('Donor ID: '
                       || v_donor_id);
  DBMS_OUTPUT.PUT_LINE('Pledge Amount: $'
                       || v_pledge_amount);
  DBMS_OUTPUT.PUT_LINE('Total Paid So Far: $'
                       || NVL(v_total_paid, 0));
  DBMS_OUTPUT.PUT_LINE('Difference: $'
                       || v_difference);
END;
