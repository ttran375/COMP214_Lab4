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
    v_donor_type CHAR(1) := 'I'; -- Replace with the actual donor type code ('I', 'B', or 'G')
    v_pledge_amount NUMBER := 300; -- Replace with the actual pledge amount

    v_matching_percent NUMBER;
    v_matching_amount NUMBER;

BEGIN
    IF v_donor_type = 'I' THEN
        IF v_pledge_amount >= 100 AND v_pledge_amount <= 249 THEN
            v_matching_percent := 0.5;
        ELSIF v_pledge_amount >= 250 AND v_pledge_amount <= 499 THEN
            v_matching_percent := 0.3;
        ELSE
            v_matching_percent := 0.2;
        END IF;

    ELSIF v_donor_type = 'B' THEN
        IF v_pledge_amount >= 100 AND v_pledge_amount <= 499 THEN
            v_matching_percent := 0.2;
        ELSIF v_pledge_amount >= 500 AND v_pledge_amount <= 999 THEN
            v_matching_percent := 0.1;
        ELSE
            v_matching_percent := 0.05;
        END IF;

    ELSIF v_donor_type = 'G' THEN
        IF v_pledge_amount >= 100 THEN
            v_matching_percent := 0.05;
        END IF;

    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid donor type');
        RETURN;
    END IF;

    v_matching_amount := v_pledge_amount * v_matching_percent;

    DBMS_OUTPUT.PUT_LINE('Donor Type: ' || v_donor_type);
    DBMS_OUTPUT.PUT_LINE('Pledge Amount: $' || v_pledge_amount);
    DBMS_OUTPUT.PUT_LINE('Matching Percentage: ' || TO_CHAR(v_matching_percent*100) || '%');
    DBMS_OUTPUT.PUT_LINE('Matching Amount: $' || v_matching_amount);

END;
/


-- Case Projects
-- Case 2-1: Flowcharting
-- Find a Web site with basic information on flowcharting. Describe at least two interesting aspects of flowcharting discussed on the Web site.
-- 1. Flowcharting is a visual representation of a process or algorithm, using different shapes and symbols to represent different steps and decisions in the process.
-- 2. Flowcharting is a useful tool for planning and documenting processes, as well as for communicating complex processes to others in a clear and understandable manner.

-- Case 2-2: Working with More Movie Rentals
-- The More Movie Rentals Company wants to display a rating value for a movie based on the number of times the movie has been rented. The rating assignments are outlined in the following chart:
-- |------------------|--------------|
-- |Number of Rentals |Rental Rating |
-- |------------------|--------------|
-- |Up to 5           |Dump          |
-- |5–20              |Low           |
-- |21–35             |Mid           |
-- |More than 35      |High          |
-- |------------------|--------------|
-- Create a flowchart and then a PL/SQL block to address the processing needed. The block should determine and then display the correct rental rating. Test the block, using a variety of rental amounts.
DECLARE
    v_number_of_rentals NUMBER := 25; -- Replace with the actual number of rentals

    v_rental_rating VARCHAR2(10);

BEGIN
    IF v_number_of_rentals <= 5 THEN
        v_rental_rating := 'Dump';
    ELSIF v_number_of_rentals <= 20 THEN
        v_rental_rating := 'Low';
    ELSIF v_number_of_rentals <= 35 THEN
        v_rental_rating := 'Mid';
    ELSE
        v_rental_rating := 'High';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Number of Rentals: ' || v_number_of_rentals);
    DBMS_OUTPUT.PUT_LINE('Rental Rating: ' || v_rental_rating);

END;
/
