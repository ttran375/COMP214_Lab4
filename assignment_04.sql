-- Assignment 2-4: Using CASE Statements
-- Create a block using a CASE statement to perform the actions described in Assignment 2-2. Use a scalar variable for the total purchase amount, and initialize this variable to different values to test your block.
DECLARE
    TOTAL_PURCHASES NUMBER := 150; -- Initialize total purchases to test the block
BEGIN
 -- Enter Total Purchases
    DBMS_OUTPUT.PUT_LINE('Enter Total Purchases: '
                         || TOTAL_PURCHASES);
 -- Evaluate the rating based on total purchases using CASE statement
    CASE
        WHEN TOTAL_PURCHASES > 200 THEN
 -- Customer Rated High
            DBMS_OUTPUT.PUT_LINE('Customer Rated High');
 -- Display "High Rating"
            DBMS_OUTPUT.PUT_LINE('Display "High Rating"');
        WHEN TOTAL_PURCHASES > 100 THEN
 -- Customer Rated Mid
            DBMS_OUTPUT.PUT_LINE('Customer Rated Mid');
 -- Display "Mid Rating"
            DBMS_OUTPUT.PUT_LINE('Display "Mid Rating"');
        ELSE
 -- Customer Rated Low
            DBMS_OUTPUT.PUT_LINE('Customer Rated Low');
 -- Display "Low Rating"
            DBMS_OUTPUT.PUT_LINE('Display "Low Rating"');
    END CASE;
 -- End of Block
    DBMS_OUTPUT.PUT_LINE('End of Block');
END;
/
