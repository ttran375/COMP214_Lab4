-- Assignment 2-3: Using IF Statements
-- Create a block using an IF statement to perform the actions described in Assignment 2-2. Use a scalar variable for the total purchase amount, and initialize this variable to different values to test your block.
DECLARE
    TOTAL_PURCHASES NUMBER := 150; -- Initialize total purchases to test the block
    HIGH_LIMIT      NUMBER := 200;
    MID_LIMIT       NUMBER := 100;
BEGIN
 -- Enter Total Purchases
    DBMS_OUTPUT.PUT_LINE('Enter Total Purchases: '
                         || TOTAL_PURCHASES);
 -- Check the rating based on total purchases
    IF TOTAL_PURCHASES > HIGH_LIMIT THEN
 -- Customer Rated High
        DBMS_OUTPUT.PUT_LINE('Customer Rated High');
 -- Display "High Rating"
        DBMS_OUTPUT.PUT_LINE('Display "High Rating"');
    ELSIF TOTAL_PURCHASES > MID_LIMIT THEN
 -- Customer Rated Mid
        DBMS_OUTPUT.PUT_LINE('Customer Rated Mid');
 -- Display "Mid Rating"
        DBMS_OUTPUT.PUT_LINE('Display "Mid Rating"');
    ELSE
 -- Customer Rated Low
        DBMS_OUTPUT.PUT_LINE('Customer Rated Low');
 -- Display "Low Rating"
        DBMS_OUTPUT.PUT_LINE('Display "Low Rating"');
    END IF;
 -- End of Flowchart
    DBMS_OUTPUT.PUT_LINE('End of Flowchart');
END;
/
