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
