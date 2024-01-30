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


DECLARE
    v_table_name VARCHAR2(30) := 'MY_TABLE';
    v_column1_name VARCHAR2(30) := 'ID';
    v_column1_type VARCHAR2(30) := 'NUMBER(4) PRIMARY KEY';
    v_column2_name VARCHAR2(30) := 'NAME';
    v_column2_type VARCHAR2(30) := 'VARCHAR2(50)';
    v_sql_statement VARCHAR2(200);
BEGIN
    -- Creating the SQL statement dynamically
    v_sql_statement := 'CREATE TABLE ' || v_table_name || ' (' ||
                       v_column1_name || ' ' || v_column1_type || ', ' ||
                       v_column2_name || ' ' || v_column2_type || ')';

    -- Executing the SQL statement
    EXECUTE IMMEDIATE v_sql_statement;

    -- Committing the changes
    COMMIT;
END;
/


DECLARE
    v_table_name VARCHAR2(30) := 'MY_TABLE';
    v_column1_name VARCHAR2(30) := 'ID';
    v_column1_type VARCHAR2(30) := 'NUMBER(4) PRIMARY KEY';
    v_column2_name VARCHAR2(30) := 'NAME';
    v_column2_type VARCHAR2(30) := 'VARCHAR2(50)';
    v_sql_statement VARCHAR2(200);
BEGIN
    -- Creating the SQL statement dynamically
    v_sql_statement := 'CREATE TABLE ' || v_table_name || ' (' ||
                       v_column1_name || ' ' || v_column1_type || ', ' ||
                       v_column2_name || ' ' || v_column2_type || ')';

    -- Executing the SQL statement
    EXECUTE IMMEDIATE v_sql_statement;

    -- Committing the changes
    COMMIT;
END;
/

DECLARE
    v_table_name VARCHAR2(30) := 'MY_TABLE';
    v_column1_name VARCHAR2(30) := 'ID';
    v_column1_type VARCHAR2(30) := 'NUMBER(4) PRIMARY KEY';
    v_column2_name VARCHAR2(30) := 'NAME';
    v_column2_type VARCHAR2(30) := 'VARCHAR2(50)';
    v_sql_statement VARCHAR2(200);
BEGIN
    -- Creating the SQL statement dynamically
    v_sql_statement := 'CREATE TABLE ' || v_table_name || ' (' ||
                       v_column1_name || ' ' || v_column1_type || ', ' ||
                       v_column2_name || ' ' || v_column2_type || ')';

    -- Executing the SQL statement
    EXECUTE IMMEDIATE v_sql_statement;

    -- Committing the changes
    COMMIT;
END;
/

DECLARE
    v_table_name VARCHAR2(30) := 'MY_TABLE';
    v_column1_name VARCHAR2(30) := 'ID';
    v_column1_type VARCHAR2(30) := 'NUMBER(4) PRIMARY KEY';
    v_column2_name VARCHAR2(30) := 'NAME';
    v_column2_type VARCHAR2(30) := 'VARCHAR2(50)';
    v_sql_statement VARCHAR2(200);
BEGIN
    -- Creating the SQL statement dynamically
    v_sql_statement := 'CREATE TABLE ' || v_table_name || ' (' ||
                       v_column1_name || ' ' || v_column1_type || ', ' ||
                       v_column2_name || ' ' || v_column2_type || ')';

    -- Executing the SQL statement
    EXECUTE IMMEDIATE v_sql_statement;

    -- Committing the changes
    COMMIT;
END;
/

DECLARE
    v_table_name VARCHAR2(30) := 'MY_TABLE';
    v_column1_name VARCHAR2(30) := 'ID';
    v_column1_type VARCHAR2(30) := 'NUMBER(4) PRIMARY KEY';
    v_column2_name VARCHAR2(30) := 'NAME';
    v_column2_type VARCHAR2(30) := 'VARCHAR2(50)';
    v_sql_statement VARCHAR2(200);
BEGIN
    -- Creating the SQL statement dynamically
    v_sql_statement := 'CREATE TABLE ' || v_table_name || ' (' ||
                       v_column1_name || ' ' || v_column1_type || ', ' ||
                       v_column2_name || ' ' || v_column2_type || ')';

    -- Executing the SQL statement
    EXECUTE IMMEDIATE v_sql_statement;

    -- Committing the changes
    COMMIT;
END;
/

DECLARE
    v_table_name VARCHAR2(30) := 'MY_TABLE';
    v_column1_name VARCHAR2(30) := 'ID';
    v_column1_type VARCHAR2(30) := 'NUMBER(4) PRIMARY KEY';
    v_column2_name VARCHAR2(30) := 'NAME';
    v_column2_type VARCHAR2(30) := 'VARCHAR2(50)';
    v_sql_statement VARCHAR2(200);
BEGIN
    -- Creating the SQL statement dynamically
    v_sql_statement := 'CREATE TABLE ' || v_table_name || ' (' ||
                       v_column1_name || ' ' || v_column1_type || ', ' ||
                       v_column2_name || ' ' || v_column2_type || ')';

    -- Executing the SQL statement
    EXECUTE IMMEDIATE v_sql_statement;

    -- Committing the changes
    COMMIT;
END;
/
