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
