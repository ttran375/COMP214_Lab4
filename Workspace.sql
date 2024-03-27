-- Assignment 9-2: Updating Stock Information When a Product Request Is Filled
-- Brewbean’s has a BB_PRODUCT_REQUEST table where requests to refill stock levels are
-- inserted automatically via a trigger. After the stock level falls below the reorder level, this trigger
-- fires and enters a request in the table. This procedure works great; however, when store clerks
-- record that the product request has been filled by updating the table’s DTRECD and COST
-- columns, they want the stock level in the product table to be updated. Create a trigger named
-- BB_REQFILL_TRG to handle this task, using the following steps as a guideline:
-- 1. In SQL Developer, run the following INSERT statement to create a product request you can
-- use in this assignment:
-- INSERT INTO bb_product_request (idRequest, idProduct, dtRequest, qty)
-- VALUES (3, 5, SYSDATE, 45);
-- COMMIT;
-- 2. Create the trigger (BB_REQFILL_TRG) so that it fires when a received date is entered in the
-- BB_PRODUCT_REQUEST table. This trigger needs to modify the STOCK column in the
-- BB_PRODUCT table to reflect the increased inventory.
-- 3. Now test the trigger. First, query the stock and reorder data for product 5, as shown in
-- Figure 9-38.
-- SELECT stock, reorder FROM bb_product
-- WHERE idProduct = 5;
-- SELECT *
-- FROM bb_product_request WHERE idProduct = 5;
-- FIGURE 9-38 Querying the data for product 5 stock and reorder amount
-- 4. Now update the product request to record it as fulfilled by using the UPDATE statement
-- shown in Figure 9-39.
-- UPDATE
-- bb_product_request
-- SET dtRecd= SYSDATE, cost = 225
-- WHERE idRequest = 3;
-- SELECT *
-- FROM bb_product_request WHERE idProduct = 5;
-- SELECT stock, reorder FROM bb_product
-- WHERE idProduct = 5;
-- 5. Issue queries to verify that the trigger fired and the stock level of product 5 has been
-- modified correctly. Then issue a ROLLBACK statement to undo the modifications.
-- 6. If you aren’t doing Assignment 9-3, disable the trigger so that it doesn’t affect
-- other assignments.

-- Insert a product request
INSERT INTO bb_product_request (
  idRequest,
  idProduct,
  dtRequest,
  qty
) VALUES (
  3,
  5,
  SYSDATE,
  45
);

COMMIT;

-- Create the trigger
CREATE OR REPLACE TRIGGER BB_REQFILL_TRG AFTER
  UPDATE OF dtRecd, cost ON bb_product_request FOR EACH ROW
BEGIN
  IF :OLD.dtRecd IS NULL AND :NEW.dtRecd IS NOT NULL THEN -- Check if dtRecd is updated
 -- Update stock level in bb_product table
    UPDATE bb_product
    SET
      stock = stock + :NEW.qty
    WHERE
      idProduct = :NEW.idProduct;
  END IF;
END;
/

-- Test the trigger
-- Query stock and reorder data for product 5
SELECT
  stock,
  reorder
FROM
  bb_product
WHERE
  idProduct = 5;

SELECT
  *
FROM
  bb_product_request
WHERE
  idProduct = 5;

-- Update the product request to record it as fulfilled
UPDATE bb_product_request
SET
  dtRecd = SYSDATE,
  cost = 225
WHERE
  idRequest = 3;

SELECT
  *
FROM
  bb_product_request
WHERE
  idProduct = 5;

SELECT
  stock,
  reorder
FROM
  bb_product
WHERE
  idProduct = 5;

-- Verify trigger fired and stock level modified correctly
-- Rollback changes
ROLLBACK;

-- Disable the trigger (if not needed for other assignments)
-- ALTER TRIGGER BB_REQFILL_TRG DISABLE;

-- Assignment 9-3: Updating the Stock Level If a Product Fulfillment Is Canceled
-- The Brewbean’s developers have made progress on the inventory-handling processes;
-- however, they hit a snag when a store clerk incorrectly recorded a product request as fulfilled.
-- When the product request was updated to record a DTRECD value, the product’s stock level
-- was updated automatically via an existing trigger, BB_REQFILL_TRG. If the clerk empties the
-- DTRECD column to indicate that the product request hasn’t been filled, the product’s stock
-- level needs to be corrected or reduced, too. Modify the BB_REQFILL_TRG trigger to solve
-- this problem.
-- 1. Modify the trigger code from Assignment 9-2 as needed. Add code to check whether the
-- DTRECD column already has a date in it and is now being set to NULL.
-- 2. Issue the following DML actions to create and update rows that you can use to test
-- the trigger:
-- INSERT INTO bb_product_request (idRequest, idProduct, dtRequest, qty,
-- dtRecd, cost)
-- VALUES (4, 5, SYSDATE, 45, '15-JUN-2012',225);
-- UPDATE bb_product
-- SET stock = 86
-- WHERE idProduct = 5;
-- COMMIT;
-- 3. Run the following UPDATE statement to test the trigger, and issue queries to verify that the
-- data has been modified correctly.
-- UPDATE bb_product_request
-- SET dtRecd = NULL
-- WHERE idRequest = 4;
-- 4. Be sure to run the following statement to disable this trigger so that it doesn’t affect other
-- assignments:
-- ALTER TRIGGER bb_reqfill_trg DISABLE;
-- Create the trigger
CREATE OR REPLACE TRIGGER BB_REQFILL_TRG AFTER
  UPDATE OF dtRecd, cost ON bb_product_request FOR EACH ROW
BEGIN
  -- Check if dtRecd is updated from not null to null
  IF :OLD.dtRecd IS NOT NULL AND :NEW.dtRecd IS NULL THEN
    -- Reduce stock level in bb_product table
    UPDATE bb_product
    SET
      stock = stock - :OLD.qty
    WHERE
      idProduct = :NEW.idProduct;
  ELSIF :OLD.dtRecd IS NULL AND :NEW.dtRecd IS NOT NULL THEN
    -- Update stock level in bb_product table
    UPDATE bb_product
    SET
      stock = stock + :NEW.qty
    WHERE
      idProduct = :NEW.idProduct;
  END IF;
END;
/

-- Test the trigger
-- Insert a product request
INSERT INTO bb_product_request (
  idRequest,
  idProduct,
  dtRequest,
  qty
) VALUES (
  4,
  5,
  SYSDATE,
  45
);
COMMIT;

-- Update the product stock to a specific value
UPDATE bb_product
SET
  stock = 86
WHERE
  idProduct = 5;
COMMIT;

-- Update the product request to record it as unfulfilled
UPDATE bb_product_request
SET
  dtRecd = NULL
WHERE
  idRequest = 4;

-- Query to verify data modifications
SELECT * FROM bb_product_request WHERE idRequest = 4;
SELECT stock FROM bb_product WHERE idProduct = 5;

-- Disable the trigger (if not needed for other assignments)
ALTER TRIGGER BB_REQFILL_TRG DISABLE;
