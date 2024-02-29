-- Assignment 2-1: Using Scalar Variables
-- Create a PL/SQL block containing the following variables:
-- Name Data Type Option Initial Value
-- lv_test_date DATE December 10, 2012
-- lv_test_num NUMBER(3) CONSTANT 10
-- lv_test_txt VARCHAR2(10)
-- Assign your last name as the value of the text variable in the executable section of the
-- block. Include statements in the block to display each variable’s value onscreen.

DECLARE
    -- Declare a DATE variable and initialize it with a specific date
    lv_test_date DATE := TO_DATE('10-DEC-2012', 'DD-MON-YYYY');
    
    -- Declare a constant NUMBER variable and initialize it with the value 10
    lv_test_num CONSTANT NUMBER(3) := 10;
    
    -- Declare a VARCHAR2 variable
    lv_test_txt VARCHAR2(10);
BEGIN
    -- Assign the string 'Copilot' to the lv_test_txt variable
    lv_test_txt := 'Copilot';
    
    -- Output the date variable in 'DD-MON-YYYY' format
    DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(lv_test_date, 'DD-MON-YYYY'));
    
    -- Output the number variable
    DBMS_OUTPUT.PUT_LINE('Number: ' || lv_test_num);
    
    -- Output the text variable
    DBMS_OUTPUT.PUT_LINE('Text: ' || lv_test_txt);
END;
