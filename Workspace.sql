-- - Assignment 2-1: Using Scalar Variables
DECLARE
    LV_TEST_DATE DATE := '10-DEC-2012';
    LV_TEST_NUM  NUMBER(3) := 10;
    LV_TEST_TXT  VARCHAR2(10);
BEGIN
    LV_TEST_TXT := '???????';
    DBMS_OUTPUT.PUT_LINE(LV_TEST_DATE);
    DBMS_OUTPUT.PUT_LINE(LV_TEST_NUM);
    DBMS_OUTPUT.PUT_LINE(LV_TEST_TXT);
END;

-- - Assignment 2-2: Creating a Flowchart
-- - Assignment 2-3: Using IF Statements
DECLARE
    LV_TOTAL_NUM NUMBER(6, 2) := 150;
BEGIN
    IF LV_TOTAL_NUM > 200 THEN
        DBMS_OUTPUT.PUT_LINE('HIGH');
    ELSIF LV_TOTAL_NUM > 100 THEN
        DBMS_OUTPUT.PUT_LINE('MID');
    ELSE
        DBMS_OUTPUT.PUT_LINE('LOW');
    END IF;
END;

-- - Assignment 2-4: Using CASE Statements
DECLARE
    LV_TOTAL_NUM NUMBER(6, 2) := 150;
BEGIN
    CASE
        WHEN LV_TOTAL_NUM > 200 THEN
            DBMS_OUTPUT.PUT_LINE('HIGH');
        WHEN LV_TOTAL_NUM > 100 THEN
            DBMS_OUTPUT.PUT_LINE('MID');
        ELSE
            DBMS_OUTPUT.PUT_LINE('LOW');
    END CASE;
END;
 
-- - Assignment 2-5: Using a Boolean Variable
DECLARE
    LV_BAL_NUM NUMBER(8, 2) := 150.50;
    LV_PAY_NUM NUMBER(8, 2) := 95.00;
    LV_DUE_BLN BOOLEAN;
BEGIN
    IF (LV_BAL_NUM - LV_PAY_NUM) > 0 THEN
        LV_DUE_BLN := TRUE;
        DBMS_OUTPUT.PUT_LINE('Balance Due');
    ELSE
        LV_DUE_BLN := FALSE;
        DBMS_OUTPUT.PUT_LINE('Account Fully Paid');
    END IF;
END;

-- - Assignment 2-6: Using Looping Statements
DECLARE
    LV_TOTAL_NUM NUMBER(6, 2) := 200;
    LV_PRICE_NUM NUMBER(5, 2) := 32;
    LV_SPENT_NUM NUMBER(6, 2) := 0;
    LV_QTY_NUM   NUMBER(6) := 0;
BEGIN
    WHILE (LV_SPENT_NUM + LV_PRICE_NUM) < LV_TOTAL_NUM LOOP
        LV_SPENT_NUM := LV_SPENT_NUM + LV_PRICE_NUM;
        LV_QTY_NUM := LV_QTY_NUM + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total Spent = '
                         || LV_SPENT_NUM);
    DBMS_OUTPUT.PUT_LINE('# purchase = '
                         || LV_QTY_NUM);
END;

-- - Assignment 2-7: Creating a Flowchart
-- - Assignment 2-8: Using IF Statements
DECLARE
    LV_MEM_TXT  CHAR(1) := 'Y';
    LV_QTY_NUM  NUMBER(3) := 8;
    LV_SHIP_NUM NUMBER(6, 2);
BEGIN
    IF LV_MEM_TXT = 'Y' THEN
        IF LV_QTY_NUM > 10 THEN
            LV_SHIP_NUM := 9;
        ELSIF LV_QTY_NUM >= 7 THEN
            LV_SHIP_NUM := 7;
        ELSIF LV_QTY_NUM >= 4 THEN
            LV_SHIP_NUM := 5;
        ELSE
            LV_SHIP_NUM := 3;
        END IF;
    ELSE
        IF LV_QTY_NUM > 10 THEN
            LV_SHIP_NUM := 12;
        ELSIF LV_QTY_NUM >= 7 THEN
            LV_SHIP_NUM := 10;
        ELSIF LV_QTY_NUM >= 4 THEN
            LV_SHIP_NUM := 7.50;
        ELSE
            LV_SHIP_NUM := 5;
        END IF;
    END IF;

    DBMS_OUTPUT.PUT_LINE(LV_SHIP_NUM);
END;

-- - Assignment 2-9: Using a FOR Loop
DECLARE
    LV_START_DATE   DATE := '01-OCT-2012';
    LV_PAYAMT_NUM   NUMBER(8, 2) := 20;
    LV_PAYMTHS_NUM  NUMBER(8, 2) := 24;
    LV_BAL_NUM      NUMBER(8, 2) := 0;
    LV_DUEDATE_DATE DATE;
    LV_DUEDATE_TXT  VARCHAR2(25);
BEGIN
    LV_BAL_NUM := LV_PAYAMT_NUM * LV_PAYMTHS_NUM;
    LV_DUEDATE_DATE := LV_START_DATE;
    FOR I IN 1..LV_PAYMTHS_NUM LOOP
        LV_BAL_NUM := LV_BAL_NUM - LV_PAYAMT_NUM;
        LV_DUEDATE_TXT := TO_CHAR(LV_DUEDATE_DATE, 'mm/dd/yyyy');
        DBMS_OUTPUT.PUT_LINE('Pay #: '
                             || I
                             || ' Due: '
                             || LV_DUEDATE_TXT
                             || ' Amt: '
                             || TO_CHAR(LV_PAYAMT_NUM, '$999.99')
                                || ' Bal: '
                                || TO_CHAR(LV_BAL_NUM, '$9,999.99'));
        LV_DUEDATE_DATE := ADD_MONTHS(LV_DUEDATE_DATE, 1);
    END LOOP;
END;

-- - Assignment 2-10: Using a Basic Loop
DECLARE
    LV_START_DATE   DATE := '01-OCT-2012';
    LV_PAYAMT_NUM   NUMBER(8, 2) := 20;
    LV_PAYMTHS_NUM  NUMBER(8, 2) := 24;
    LV_BAL_NUM      NUMBER(8, 2) := 0;
    LV_DUEDATE_DATE DATE;
    LV_DUEDATE_TXT  VARCHAR2(25);
    LV_CNT_NUM      NUMBER(2) := 1;
BEGIN
    LV_BAL_NUM := LV_PAYAMT_NUM * LV_PAYMTHS_NUM;
    LV_DUEDATE_DATE := LV_START_DATE;
    LOOP
        LV_BAL_NUM := LV_BAL_NUM - LV_PAYAMT_NUM;
        LV_DUEDATE_TXT := TO_CHAR(LV_DUEDATE_DATE, 'mm/dd/yyyy');
        DBMS_OUTPUT.PUT_LINE('Pay #: '
                             || LV_CNT_NUM
                             || ' Due: '
                             || LV_DUEDATE_TXT
                             || ' Amt: '
                             || TO_CHAR(LV_PAYAMT_NUM, '$999.99')
                                || ' Bal: '
                                || TO_CHAR(LV_BAL_NUM, '$9,999.99'));
        LV_DUEDATE_DATE := ADD_MONTHS(LV_DUEDATE_DATE, 1);
        EXIT WHEN (LV_CNT_NUM = LV_PAYMTHS_NUM);
        LV_CNT_NUM := LV_CNT_NUM + 1;
    END LOOP;
END;
