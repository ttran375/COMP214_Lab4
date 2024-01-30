DECLARE
    v_isbn VARCHAR2(10);
    v_title VARCHAR2(30);
    v_pubdate DATE;
    v_retail NUMBER(5,2);
    v_category VARCHAR2(12);
BEGIN
    -- Query to retrieve a single row from the BOOKS table
    SELECT ISBN, Title, PubDate, Retail, Category
    INTO v_isbn, v_title, v_pubdate, v_retail, v_category
    FROM BOOKS
    WHERE ROWNUM = 1; -- Change the condition based on your requirement

    -- Display the values or perform further operations with the variables
    DBMS_OUTPUT.PUT_LINE('ISBN: ' || v_isbn);
    DBMS_OUTPUT.PUT_LINE('Title: ' || v_title);
    DBMS_OUTPUT.PUT_LINE('PubDate: ' || TO_CHAR(v_pubdate, 'DD-MON-YY'));
    DBMS_OUTPUT.PUT_LINE('Retail: ' || v_retail);
    DBMS_OUTPUT.PUT_LINE('Category: ' || v_category);
END;
/

CREATE OR REPLACE TRIGGER update_project_status
AFTER INSERT OR UPDATE ON DD_Payment
FOR EACH ROW
DECLARE
    total_paid NUMBER;
BEGIN
    -- Calculate the total amount paid for the project
    SELECT NVL(SUM(Payamt), 0) INTO total_paid
    FROM DD_Payment
    WHERE idPledge = :NEW.idPledge;

    -- Update project status based on the total paid amount
    IF total_paid >= (
        SELECT Projfundgoal
        FROM DD_Project
        WHERE idProj = (
            SELECT idProj
            FROM DD_Pledge
            WHERE idPledge = :NEW.idPledge
        )
    ) THEN
        UPDATE DD_Project
        SET Projstatus = 'Complete'
        WHERE idProj = (
            SELECT idProj
            FROM DD_Pledge
            WHERE idPledge = :NEW.idPledge
        );
    ELSE
        UPDATE DD_Project
        SET Projstatus = 'Open'
        WHERE idProj = (
            SELECT idProj
            FROM DD_Pledge
            WHERE idPledge = :NEW.idPledge
        );
    END IF;
END;
/
