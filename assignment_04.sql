-- Assignment 2-4: Using CASE Statements
-- Create a block using a CASE statement to perform the actions described in Assignment 2-2. Use a scalar variable for the total purchase amount, and initialize this variable to different values to test your block.
DECLARE
    lv_total_purchases NUMBER := 150;
    lv_high_limit NUMBER := 200;
    lv_mid_limit NUMBER := 100;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Enter Total Purchases: ' || lv_total_purchases);

    CASE
        WHEN lv_total_purchases > lv_high_limit THEN
            DBMS_OUTPUT.PUT_LINE('Customer Rated High');
            DBMS_OUTPUT.PUT_LINE('Display "High Rating"');
        WHEN lv_total_purchases > lv_mid_limit THEN
            DBMS_OUTPUT.PUT_LINE('Customer Rated Mid');
            DBMS_OUTPUT.PUT_LINE('Display "Mid Rating"');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer Rated Low');
            DBMS_OUTPUT.PUT_LINE('Display "Low Rating"');
    END CASE;

    DBMS_OUTPUT.PUT_LINE('End of Flowchart');
END;
/
