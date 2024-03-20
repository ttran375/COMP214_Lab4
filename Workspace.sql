-- Assignment 9-8: Maintaining an Audit Trail of Product Table Changes
-- The accuracy of product table data is critical, and the Brewbean’s owner wants to have an audit
-- file containing information on all DML activity on the BB_PRODUCT table. This information
-- should include the ID of the user performing the DML action, the date, the original values of the
-- changed row, and the new values. This audit table needs to track specific columns of concern,
-- including PRODUCTNAME, PRICE, SALESTART, SALEEND, and SALEPRICE. Create a table
-- named BB_PRODCHG_AUDIT to hold the relevant data, and then create a trigger named
-- BB_AUDIT_TRG that fires an update to this table whenever a specified column in the
-- BB_PRODUCT table changes.
-- TIP
-- Multiple columns can be listed in a trigger’s OF clause by separating them with commas.
-- Be sure to issue the following command. If you created the SALES_DATE_TRG trigger in the
-- chapter, it conflicts with this assignment.
-- ALTER TRIGGER sales_date_trg DISABLE;
-- Use the following UPDATE statement to test the trigger:
-- UPDATE bb_product
-- SET salestart = '05-MAY-2012',
-- saleend = '12-MAY-2012'
-- saleprice = 9
-- WHERE idProduct = 10;
-- When you’re finished, do a rollback and disable the trigger so that it doesn’t affect other
-- assignments.

CREATE TABLE BB_PRODCHG_AUDIT (
  AUDIT_ID NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  USER_ID VARCHAR2(30),
  ACTION_DATE TIMESTAMP,
  PRODUCT_ID NUMBER(10),
  OLD_PRODUCTNAME VARCHAR2(255),
  NEW_PRODUCTNAME VARCHAR2(255),
  OLD_PRICE NUMBER,
  NEW_PRICE NUMBER,
  OLD_SALESTART DATE,
  NEW_SALESTART DATE,
  OLD_SALEEND DATE,
  NEW_SALEEND DATE,
  OLD_SALEPRICE NUMBER,
  NEW_SALEPRICE NUMBER
);

CREATE OR REPLACE TRIGGER BB_AUDIT_TRG AFTER
  UPDATE OF PRODUCTNAME, PRICE, SALESTART, SALEEND, SALEPRICE ON BB_PRODUCT FOR EACH ROW
BEGIN
  INSERT INTO BB_PRODCHG_AUDIT (
    USER_ID,
    ACTION_DATE,
    PRODUCT_ID,
    OLD_PRODUCTNAME,
    NEW_PRODUCTNAME,
    OLD_PRICE,
    NEW_PRICE,
    OLD_SALESTART,
    NEW_SALESTART,
    OLD_SALEEND,
    NEW_SALEEND,
    OLD_SALEPRICE,
    NEW_SALEPRICE
  ) VALUES (
    USER,
    SYSTIMESTAMP,
    :OLD.IDPRODUCT,
    :OLD.PRODUCTNAME,
    :NEW.PRODUCTNAME,
    :OLD.PRICE,
    :NEW.PRICE,
    :OLD.SALESTART,
    :NEW.SALESTART,
    :OLD.SALEEND,
    :NEW.SALEEND,
    :OLD.SALEPRICE,
    :NEW.SALEPRICE
  );
END;
/

UPDATE BB_PRODUCT
SET
  SALESTART = '05-MAY-2012',
  SALEEND = '12-MAY-2012',
  SALEPRICE = 9
WHERE
  IDPRODUCT = 10;

ROLLBACK;

ALTER TRIGGER BB_AUDIT_TRG DISABLE;
