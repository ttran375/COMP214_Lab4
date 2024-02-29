-- Assignment 2-3: Using IF Statements
-- Create a block using an IF statement to perform the actions described in Assignment 2-2. Use a scalar variable for the total purchase amount, and initialize this variable to different values to test your block.
DECLARE
    lv_total_purchases NUMBER := 150;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Enter Total Purchases: ' || lv_total_purchases);

    IF lv_total_purchases > 200 THEN
        DBMS_OUTPUT.PUT_LINE('Customer Rated High');
        DBMS_OUTPUT.PUT_LINE('Display "High Rating"');
    ELSIF lv_total_purchases > 100 THEN
        DBMS_OUTPUT.PUT_LINE('Customer Rated Mid');
        DBMS_OUTPUT.PUT_LINE('Display "Mid Rating"');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Customer Rated Low');
        DBMS_OUTPUT.PUT_LINE('Display "Low Rating"');
    END IF;

    DBMS_OUTPUT.PUT_LINE('End of Flowchart');
END;
/
