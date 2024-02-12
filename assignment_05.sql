-- Assignment 3-5: Using a WHILE Loop
-- Brewbean’s wants to include a feature in its application that calculates the total amount (quantity)
-- of a specified item that can be purchased with a given amount of money. Create a block with a
-- WHILE loop to increment the item’s cost until the dollar value is met. Test first with a total spending
-- amount of $100 and product ID 4. Then test with an amount and a product of your choice. Use
-- initialized variables to provide the total spending amount and product ID.
DECLARE
  lv_total_spend NUMBER(6, 2) := 100; -- total spending amount
  lv_prod_id     bb_product.idproduct%TYPE := 4; -- product ID
  lv_prod_price  NUMBER(6, 2);
  lv_quantity    NUMBER(6, 2) := 0;
BEGIN
  SELECT
    price INTO lv_prod_price
  FROM
    bb_product
  WHERE
    idproduct = lv_prod_id;
  WHILE lv_total_spend >= lv_prod_price LOOP
    lv_total_spend := lv_total_spend - lv_prod_price;
    lv_quantity := lv_quantity + 1;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('With $100, you can buy '
                       ||lv_quantity
                       ||' units of product ID '
                       ||lv_prod_id);
END;
