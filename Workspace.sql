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
lv_taxrate_num CONSTANT NUMBER(2,2) := .06;
lv_total_num NUMBER(6,2) := 50;
lv_taxamt_num NUMBER(4,2);
BEGIN
lv_taxamt_num := lv_total_num * lv_taxrate_num;
DBMS_OUTPUT.PUT_LINE(lv_taxamt_num);
END;
/
