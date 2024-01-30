-- Creating a PL/SQL Procedure
CREATE OR REPLACE PROCEDURE CALCULATE_TOTAL_PAYMENT IS
 -- Declare variables for cursor and result
    CURSOR PROJECT_CURSOR IS
    SELECT
        IDPROJ,
        PROJNAME
    FROM
        DD_PROJECT;
    PROJECT_ID    DD_PROJECT.IDPROJ%TYPE;
    PROJECT_NAME  DD_PROJECT.PROJNAME%TYPE;
    TOTAL_PAYMENT NUMBER(12, 2);
BEGIN
 -- Loop through each project
    FOR PROJECT_REC IN PROJECT_CURSOR LOOP
        PROJECT_ID := PROJECT_REC.IDPROJ;
        PROJECT_NAME := PROJECT_REC.PROJNAME;
 -- Calculate total payment for each project
        SELECT
            NVL(SUM(PAYAMT), 0) INTO TOTAL_PAYMENT
        FROM
            DD_PAYMENT P
            JOIN DD_PLEDGE PL
            ON P.IDPLEDGE = PL.IDPLEDGE
        WHERE
            PL.IDPROJ = PROJECT_ID;
 -- Display the result
        DBMS_OUTPUT.PUT_LINE('Project: '
                             || PROJECT_NAME
                             || ', Total Payment: '
                             || TOTAL_PAYMENT);
    END LOOP;
END CALCULATE_TOTAL_PAYMENT;
 -- Execute the procedure
BEGIN
    CALCULATE_TOTAL_PAYMENT;
END;
/

DECLARE
    LV_TAXRATE_NUM CONSTANT NUMBER(2, 2) := .06;
    LV_TOTAL_NUM   NUMBER(6, 2) := 50;
    LV_TAXAMT_NUM  NUMBER(4, 2);
BEGIN
    LV_TAXAMT_NUM := LV_TOTAL_NUM * LV_TAXRATE_NUM;
    DBMS_OUTPUT.PUT_LINE(LV_TAXAMT_NUM);
END;
/

DECLARE
    MESSAGE VARCHAR2(50) := 'Hello, World!';
BEGIN
    DBMS_OUTPUT.PUT_LINE(MESSAGE);
END;
/

-- Scalar Variables
DECLARE
    MYNUMBER  INTEGER := 10;
    MYSTRING  VARCHAR2(20) := 'PL/SQL Example';
    MYBOOLEAN BOOLEAN := TRUE;
BEGIN
 -- Using IF Statements
    IF MYNUMBER > 5 THEN
        DBMS_OUTPUT.PUT_LINE('The number is greater than 5.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The number is 5 or less.');
    END IF;
 -- Using CASE Statements
    CASE
        WHEN MYSTRING = 'PL/SQL Example' THEN
            DBMS_OUTPUT.PUT_LINE('The string matches.');
        WHEN MYSTRING = 'Another Example' THEN
            DBMS_OUTPUT.PUT_LINE('This is a different example.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No match found.');
    END CASE;
 -- Using a Boolean Variable
    IF MYBOOLEAN THEN
        DBMS_OUTPUT.PUT_LINE('The boolean variable is TRUE.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The boolean variable is FALSE.');
    END IF;
 -- Using Looping Statements
 -- Creating a Flowchart (Textual Representation)
 -- [Start] --> [Loop Start] --> [IF condition] --> [Do something] --> [Loop End] --> [End]
 -- Using a FOR Loop
    FOR I IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('FOR Loop Iteration: '
                             || I);
    END LOOP;
 -- Using a Basic Loop
    DECLARE
        LOOPCOUNTER INTEGER := 0;
    BEGIN
        LOOP
            LOOPCOUNTER := LOOPCOUNTER + 1;
            EXIT WHEN LOOPCOUNTER > 3;
            DBMS_OUTPUT.PUT_LINE('Basic Loop Iteration: '
                                 || LOOPCOUNTER);
        END LOOP;
    END;
END;
/
