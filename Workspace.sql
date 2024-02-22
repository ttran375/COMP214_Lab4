-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE BASKET_CONFIRM_SP (
  p_basket_id IN NUMBER,
  p_subtotal IN NUMBER,
  p_shipping IN NUMBER,
  p_tax IN NUMBER,
  p_total IN NUMBER
) AS
BEGIN
  UPDATE BB_BASKET
  SET
    SUBTOTAL = p_subtotal,
    SHIPPING = p_shipping,
    TAX = p_tax,
    TOTAL = p_total,
    ORDERPLACED = 1
  WHERE
    IDBASKET = p_basket_id;
  COMMIT;
END;
/

-- Step 2: Execute the provided INSERT statements to create a new basket and basket items

-- Step 3: Commit the transaction to save the data
COMMIT;

-- Step 4: Call the procedure with the provided parameter values
BEGIN
  BASKET_CONFIRM_SP(17, 64.80, 8.00, 1.94, 74.74);
END;
/

-- Step 5: Query the BB_BASKET table to confirm the changes
SELECT
  subtotal,
  shipping,
  tax,
  total,
  orderplaced
FROM
  bb_basket
WHERE
  idbasket = 17;
