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
