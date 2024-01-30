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

-- Existing code...

-- Insert statements for DD_Donor table
INSERT INTO dd_donor  
  VALUES (301, 'Mary', 'Treanor', 'I','243 main St.', 'Norfolk', 'VA','23510',NULL,NULL,'mtrea492@mdv.com','Y','01-SEP-2012');

-- Add an IF statement to check if the donor is a business ('B')
DECLARE
    v_typecode CHAR(1);
BEGIN
    v_typecode := 'B';  -- Change this to the desired typecode

    IF v_typecode = 'B' THEN
        INSERT INTO dd_donor  
        VALUES (306, NULL, 'Coastal Developers', 'B','3667 Shore Dr.', 'Virginia Beach', 'VA','23450','8889220004',NULL,'coastVA@cdev.com','Y','30-SEP-2012');
    END IF;
END;
/

-- Continue with the rest of the insert statements...

-- Existing code...
