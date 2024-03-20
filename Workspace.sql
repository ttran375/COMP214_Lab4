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
CREATE OR REPLACE TRIGGER BB_REQFILL_TRG
AFTER UPDATE OF DTRECD ON BB_PRODUCT_REQUEST
FOR EACH ROW
DECLARE
    v_qty NUMBER;
BEGIN
    IF :OLD.DTRECD IS NOT NULL AND :NEW.DTRECD IS NULL THEN
        -- Product request is being marked as not filled
        -- Adjust the product stock level
        SELECT qty INTO v_qty
        FROM bb_product_request
        WHERE idRequest = :OLD.idRequest;

        UPDATE bb_product
        SET stock = stock + v_qty
        WHERE idProduct = :OLD.idProduct;
    END IF;
END;
/
