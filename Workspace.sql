-- Assignment 5-2: Using a Procedure with IN Parameters
-- Follow these steps to create a procedure that allows a company employee to add a new
-- product to the database. This procedure needs only IN parameters.
-- 1. In SQL Developer, create a procedure named PROD_ADD_SP that adds a row for a new
-- product in the BB_PRODUCT table. Keep in mind that the user provides values for the
-- product name, description, image filename, price, and active status. Address the input
-- values or parameters in the same order as in the preceding sentence.
-- 2. Call the procedure with these parameter values: ('Roasted Blend', 'Well-balanced
-- mix of roasted beans, a medium body', 'roasted.jpg',9.50,1).
-- 3. Check whether the update was successful by querying the BB_PRODUCT table.

CREATE OR REPLACE PROCEDURE PROD_ADD_SP (
    p_ProductName IN VARCHAR2,
    p_Description IN VARCHAR2,
    p_ProductImage IN VARCHAR2,
    p_Price IN NUMBER,
    p_Active IN NUMBER
)
IS
BEGIN
    INSERT INTO BB_Product (idProduct, ProductName, Description, ProductImage, Price, Active)
    VALUES (bb_prodid_seq.NEXTVAL, p_ProductName, p_Description, p_ProductImage, p_Price, p_Active);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('New product added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END PROD_ADD_SP;
/

BEGIN
    PROD_ADD_SP('Roasted Blend', 'Well-balanced mix of roasted beans, a medium body', 'roasted.jpg', 9.50, 1);
END;
/

SELECT * FROM BB_Product;
