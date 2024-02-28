-- Assignment 5-4: Updating Columns in a Table
-- After a shopper completes an order, a procedure is called to update the following columns in the
-- BASKET table: ORDERPLACED, SUBTOTAL, SHIPPING, TAX, and TOTAL. The value 1
-- entered in the ORDERPLACED column indicates that the shopper has completed an order.
-- Inputs to the procedure are the basket ID and amounts for the subtotal, shipping, tax, and total.
-- 1. In SQL Developer, create a procedure named BASKET_CONFIRM_SP that accepts the input
-- values specified in the preceding description. Keep in mind that you’re modifying an existing
-- row of the BB_BASKET table in this procedure.
-- 2. Enter the following statements to create a new basket containing two items:
-- INSERT INTO BB_BASKET (IDBASKET, QUANTITY, IDSHOPPER,
-- ORDERPLACED, SUBTOTAL, TOTAL,
-- SHIPPING, TAX, DTCREATED, PROMO)
-- VALUES (17, 2, 22, 0, 0, 0, 0, 0, '28-FEB-12', 0);
-- INSERT INTO BB_BASKETITEM (IDBASKETITEM, IDPRODUCT, PRICE,
-- QUANTITY, IDBASKET, OPTION1, OPTION2)
-- VALUES (44, 7, 10.8, 3, 17, 2, 3);
-- INSERT INTO BB_BASKETITEM (IDBASKETITEM, IDPRODUCT, PRICE,
-- QUANTITY, IDBASKET, OPTION1, OPTION2)
-- VALUES (45, 8, 10.8, 3, 17, 2, 3);
-- 3. Type and run COMMIT; to save the data from these statements.
-- 4. Call the procedure with the following parameter values: 17, 64.80, 8.00, 1.94, 74.74.
-- As mentioned, these values represent the basket ID and the amounts for the subtotal,
-- shipping, tax, and total.
-- 5. Query the BB_BASKET table to confirm that the procedure was successful:
-- SELECT subtotal, shipping, tax, total, orderplaced
-- FROM bb_basket
-- WHERE idbasket = 17;.
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
