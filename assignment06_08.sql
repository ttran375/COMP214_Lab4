-- Assignment 6-8: Identifying Sale Products
-- When a product is placed on sale, Brewbean’s records the sale’s start and end dates in
-- columns of the BB_PRODUCT table. A function is needed to provide sales information when a
-- shopper selects an item. If a product is on sale, the function should return the value ON SALE!.
-- However, if it isn’t on sale, the function should return the value Great Deal!. These values are
-- used on the product display page. Create a function named CK_SALE_SF that accepts a date and
-- product ID as arguments, checks whether the date falls within the product’s sale period, and returns
-- the corresponding string value. Test the function with the product ID 6 and two dates: 10-JUN-12
-- and 19-JUN-12. Verify your results by reviewing the product sales information.
CREATE OR REPLACE FUNCTION CK_SALE_SF(
  p_date DATE,
  p_product_id NUMBER
) RETURN VARCHAR2 IS
  lv_sale_start DATE;
  lv_sale_end   DATE;
  lv_sale_price NUMBER(6, 2);
BEGIN
 -- Retrieve sale start date, end date, and sale price for the given product ID
  SELECT
    SaleStart,
    SaleEnd,
    SalePrice INTO lv_sale_start,
    lv_sale_end,
    lv_sale_price
  FROM
    bb_product
  WHERE
    idProduct = p_product_id;
 -- Check if the provided date falls within the sale period
  IF p_date BETWEEN lv_sale_start AND lv_sale_end THEN
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

