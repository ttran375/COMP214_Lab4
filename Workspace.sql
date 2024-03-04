CREATE OR REPLACE FUNCTION CK_SALE_SF(
  p_date DATE,
  p_product_id NUMBER
) RETURN VARCHAR2 IS
  v_sale_start DATE;
  v_sale_end   DATE;
  v_sale_price NUMBER(6, 2);
BEGIN
 -- Retrieve sale start date, end date, and sale price for the given product ID
  SELECT
    SaleStart,
    SaleEnd,
    SalePrice INTO v_sale_start,
    v_sale_end,
    v_sale_price
  FROM
    bb_product
  WHERE
    idProduct = p_product_id;
 -- Check if the provided date falls within the sale period
  IF p_date BETWEEN v_sale_start AND v_sale_end THEN
    RETURN 'ON SALE!';
  ELSE
    RETURN 'Great Deal!';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Product not found';
END CK_SALE_SF;
/

-- Test the function with the provided product ID (6) and two dates
SELECT
  CK_SALE_SF('10-JUN-2012', 6) AS Sale_Info_1,
  CK_SALE_SF('19-JUN-2012', 6) AS Sale_Info_2
FROM
  dual;
