-- Assignment 2-1: Using Scalar Variables
-- Create a PL/SQL block containing the following variables: Name Data Type Option Initial Value lv_test_date DATE December 10, 2012 lv_test_num NUMBER(3) CONSTANT 10 lv_test_txt VARCHAR2(10) Assign your last name as the value of the text variable in the executable section of the block. Include statements in the block to display each variable’s value onscreen.
DECLARE
    LV_TEST_DATE DATE := TO_DATE('10-DEC-2012', 'DD-MON-YYYY');
    LV_TEST_NUM  CONSTANT NUMBER(3) := 10;
    LV_TEST_TXT  VARCHAR2(10);
BEGIN
    LV_TEST_TXT := 'Copilot'; -- Assigning the last name
    DBMS_OUTPUT.PUT_LINE('Date: '
                         || TO_CHAR(LV_TEST_DATE, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Number: '
                         || LV_TEST_NUM);
    DBMS_OUTPUT.PUT_LINE('Text: '
                         || LV_TEST_TXT);
END;
/
