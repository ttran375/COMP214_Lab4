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

-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE PROD_ADD_SP (
  p_product_name IN VARCHAR2,
  p_description IN VARCHAR2,
  p_image_filename IN VARCHAR2,
  p_price IN NUMBER,
  p_active_status IN NUMBER
) AS
BEGIN
  INSERT INTO BB_PRODUCT (
    product_name,
    description,
    image_filename,
    price,
    active_status
  ) VALUES (
    p_product_name,
    p_description,
    p_image_filename,
    p_price,
    p_active_status
  );
  COMMIT;
END;
/

-- Step 2: Call the procedure with the specified parameter values
BEGIN
  PROD_ADD_SP('Roasted Blend', 'Well-balanced mix of roasted beans, a medium body', 'roasted.jpg', 9.50, 1);
END;
/

-- Step 3: Check whether the update was successful by querying the BB_PRODUCT table
SELECT
  *
FROM
  BB_PRODUCT;
