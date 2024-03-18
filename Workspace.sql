-- Assignment 9-1: Creating a Trigger to Handle Product Restocking
-- Brewbean’s has a couple of columns in the product table to assist in inventory tracking. The
-- REORDER column contains the stock level at which the product should be reordered. If the
-- stock falls to this level, Brewbean’s wants the application to insert a row in the
-- BB_PRODUCT_REQUEST table automatically to alert the ordering clerk that additional
-- inventory is needed. Brewbean’s currently uses the reorder level amount as the quantity that
-- should be ordered. This task can be handled by using a trigger.
-- 1. Take out some scrap paper and a pencil. Think about the tasks the triggers needs to
-- perform, including checking whether the new stock level falls below the reorder point. If so,
-- check whether the product is already on order by viewing the product request table; if not,
-- enter a new product request. Try to write the trigger code on paper. Even though you learn
-- a lot by reviewing code, you improve your skills faster when you create the code on
-- your own.
-- 2. Open the c9reorder.txt file in the Chapter09 folder. Review this trigger code, and
-- determine how it compares with your code.
-- 3. In SQL Developer, create the trigger with the provided code.
-- 4. Test the trigger with product ID 4. First, run the query shown in Figure 9-36 to verify the
-- current stock data for this product. Notice that a sale of one more item should initiate
-- a reorder.
-- FIGURE 9-36 Checking stock data
-- 5. Run the UPDATE statement shown in Figure 9-37. It should cause the trigger to fire. Notice
-- the query to check whether the trigger fired and whether a product stock request was
-- inserted in the BB_PRODUCT_REQUEST table.
-- 6. Issue a ROLLBACK statement to undo these DML actions to restore data to its original state
-- for use in later assignments.
-- 7. Run the following statement to disable this trigger so that it doesn’t affect other projects:
-- ALTER TRIGGER bb_reorder_trg DISABLE;
-- Run script to create trigger
CREATE OR REPLACE TRIGGER bb_reorder_trg AFTER
  UPDATE OF stock ON bb_product FOR EACH ROW
DECLARE
  v_onorder_num NUMBER(4);
BEGIN
  IF :NEW.stock <= :NEW.reorder THEN
    SELECT
      SUM(qty) INTO v_onorder_num
    FROM
      bb_product_request
    WHERE
      idProduct = :NEW.idProduct
      AND dtRecd IS NULL;
    IF v_onorder_num IS NULL THEN
      v_onorder_num := 0;
    END IF;

    IF v_onorder_num = 0 THEN
      INSERT INTO bb_product_request (
        idRequest,
        idProduct,
        dtRequest,
        qty
      ) VALUES (
        bb_prodreq_seq.NEXTVAL,
        :NEW.idProduct,
        SYSDATE,
        :NEW.reorder
      );
    END IF;
  END IF;
END;
/

-- Show that sale of one more of product 4
-- should initiate a reorder
SELECT
  stock,
  reorder
FROM
  bb_product
WHERE
  idProduct = 4;

/

-- Show that 4 is not currently up for reorder
SELECT
  idproduct,
  idrequest,
  dtrequest,
  qty
FROM
  bb_product_request;

/

-- Set stock equal to reorder number,
-- so trigger will fire
UPDATE bb_product
SET
  stock = 25
WHERE
  idProduct = 4;

/

-- Show that trigger fired
SELECT
  idproduct,
  idrequest,
  dtrequest,
  qty
FROM
  bb_product_request;

/

-- Rollback changes/disable trigger
ROLLBACK;

-- DROP TRIGGER bb_reorder_trg;

/
