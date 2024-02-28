-- Assignment 5-1: Creating a Procedure
-- Use these steps to create a procedure that allows a company employee to make corrections to
-- a product’s assigned name. Review the BB_PRODUCT table and identify the PRODUCT NAME
-- and PRIMARY KEY columns. The procedure needs two IN parameters to identify the product
-- ID and supply the new description. This procedure needs to perform only a DML action, so no
-- OUT parameters are necessary.
-- 1. In SQL Developer, create the following procedure:
-- CREATE OR REPLACE PROCEDURE prod_name_sp
-- (p_prodid IN bb_product.idproduct%TYPE,
-- p_descrip IN bb_product.description%TYPE)
-- IS
-- BEGIN
-- UPDATE bb_product
-- SET description = p_descrip
-- WHERE idproduct = p_prodid;
-- COMMIT;
-- END;
-- 2. Before testing the procedure, verify the current description value for product ID 1 with
-- SELECT * FROM bb_product;.
-- 3. Call the procedure with parameter values of 1 for the product ID and CapressoBar Model
-- #388 for the description.
-- 4. Verify that the update was successful by querying the table with SELECT * FROM
-- bb_product;.

CREATE OR REPLACE PROCEDURE prod_name_sp (
  p_prodid IN bb_product.idProduct%TYPE,
  p_descrip IN bb_product.Description%TYPE
) IS
BEGIN
  UPDATE bb_product
  SET
    Description = p_descrip
  WHERE
    idProduct = p_prodid;
  COMMIT;
END;
/

SELECT
  *
FROM
  bb_product
WHERE
  idProduct = 1;

BEGIN
  prod_name_sp(1, 'CapressoBar Model #388');
END;
/

SELECT
  *
FROM
  bb_product
WHERE
  idProduct = 1;
