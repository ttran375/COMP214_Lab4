-- Assignment 2-13: Using Nested IF Statements
-- An organization has committed to matching pledge amounts based on the donor type and pledge amount. Donor types include I = Individual, B = Business organization, and G = Grant funds. The matching percents are to be applied as follows:
-- |--------------------------------------|
-- |Donor Type |Pledge Amount  |Matching %|
-- |--------------------------------------|
-- |I          |$100–$249      |50%       |                  
-- |I          |$250–$499      |30%       |
-- |I          |$500 or more   |20%       |
-- |B          |$100–$499      |20%       |
-- |B          |$500–$999      |10%       |
-- |B          |$1,000 or more |5%        |
-- |G          |$100 or more   |5%        |
-- |--------------------------------------|
-- Create a PL/SQL block using nested IF statements to accomplish the task. Input values for the block are the donor type code and the pledge amount.
DECLARE
    lv_donor_type CHAR(1) := 'I';
    lv_pledge_amount NUMBER := 300;

    lv_matching_percent NUMBER;
    lv_matching_amount NUMBER;
BEGIN
    IF lv_donor_type = 'I' THEN
        IF lv_pledge_amount >= 100 AND lv_pledge_amount <= 249 THEN
            lv_matching_percent := 0.5;
        ELSIF lv_pledge_amount >= 250 AND lv_pledge_amount <= 499 THEN
            lv_matching_percent := 0.3;
        ELSE
            lv_matching_percent := 0.2;
        END IF;
    ELSIF lv_donor_type = 'B' THEN
        IF lv_pledge_amount >= 100 AND lv_pledge_amount <= 499 THEN
            lv_matching_percent := 0.2;
        ELSIF lv_pledge_amount >= 500 AND lv_pledge_amount <= 999 THEN
            lv_matching_percent := 0.1;
        ELSE
            lv_matching_percent := 0.05;
        END IF;
    ELSIF lv_donor_type = 'G' THEN
        IF lv_pledge_amount >= 100 THEN
            lv_matching_percent := 0.05;
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid donor type');
        RETURN;
    END IF;
   
    lv_matching_amount := lv_pledge_amount * lv_matching_percent;

    DBMS_OUTPUT.PUT_LINE('Donor Type: ' || lv_donor_type);
    DBMS_OUTPUT.PUT_LINE('Pledge Amount: $' || lv_pledge_amount);
    DBMS_OUTPUT.PUT_LINE('Matching Percentage: ' || TO_CHAR(lv_matching_percent * 100) || '%');
    DBMS_OUTPUT.PUT_LINE('Matching Amount: $' || lv_matching_amount);
END;
/
