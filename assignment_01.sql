-- Assignment 2-1: Using Scalar Variables
-- Create a PL/SQL block containing the following variables: Name Data Type Option Initial Value lv_test_date DATE December 10, 2012 lv_test_num NUMBER(3) CONSTANT 10 lv_test_txt VARCHAR2(10) Assign your last name as the value of the text variable in the executable section of the block. Include statements in the block to display each variable’s value onscreen.
DECLARE
    lv_test_date DATE := TO_DATE('10-DEC-2012', 'DD-MON-YYYY');
    lv_test_num CONSTANT NUMBER(3) := 10;
    lv_test_txt VARCHAR2(10);
BEGIN
    lv_test_txt := 'Copilot'; -- Assigning the last name
    DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(lv_test_date, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Number: ' || lv_test_num);
    DBMS_OUTPUT.PUT_LINE('Text: ' || lv_test_txt);
END;
/
