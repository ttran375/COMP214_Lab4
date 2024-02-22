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

/

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

/
