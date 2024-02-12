-- Assignment 3-6: Working with IF Statements
-- Brewbean’s calculates shipping cost based on the quantity of items in an order. Assume the
-- quantity column in the BB_BASKET table contains the total number of items in a basket.
-- A block is needed to check the quantity provided by an initialized variable and determine the
-- shipping cost. Display the calculated shipping cost onscreen. Test using the basket IDs 5 and
-- 12, and apply the shipping rates listed in Table 3-3.
-- TABLE 3-3 Shipping Charges
-- Quantity of Items Shipping Cost
-- Up to 3 $5.00
-- 4–6 $7.50
-- 7–10 $10.00
-- More than 10 $12.00
DECLARE
  lv_bask_id       bb_basket.idbasket%TYPE := 5;
  lv_quantity      NUMBER(6, 2);
  lv_shipping_cost NUMBER(6, 2);
BEGIN
  SELECT
    quantity INTO lv_quantity
  FROM
    bb_basket
  WHERE
    idbasket = lv_bask_id;
  IF lv_quantity <= 3 THEN
    lv_shipping_cost := 5;
  ELSIF lv_quantity <= 6 THEN
    lv_shipping_cost := 7.5;
  ELSIF lv_quantity <= 10 THEN
    lv_shipping_cost := 10;
  ELSE
    lv_shipping_cost := 12;
  END IF;

  DBMS_OUTPUT.PUT_LINE('Shipping cost for basket ID '
                       ||lv_bask_id
                       ||' is $'
                       ||lv_shipping_cost);
END;
