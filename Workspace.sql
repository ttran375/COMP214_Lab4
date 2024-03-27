-- ASSIGNMENT 9-1: CREATING A TRIGGER TO HANDLE PRODUCT RESTOCKING
-- BREWBEAN’S HAS A COUPLE OF COLUMNS IN THE PRODUCT TABLE TO ASSIST IN INVENTORY TRACKING. THE
-- REORDER COLUMN CONTAINS THE STOCK LEVEL AT WHICH THE PRODUCT SHOULD BE REORDERED. IF THE
-- STOCK FALLS TO THIS LEVEL, BREWBEAN’S WANTS THE APPLICATION TO INSERT A ROW IN THE
-- BB_PRODUCT_REQUEST TABLE AUTOMATICALLY TO ALERT THE ORDERING CLERK THAT ADDITIONAL
-- INVENTORY IS NEEDED. BREWBEAN’S CURRENTLY USES THE REORDER LEVEL AMOUNT AS THE QUANTITY THAT
-- SHOULD BE ORDERED. THIS TASK CAN BE HANDLED BY USING A TRIGGER.
-- 1. Take out some scrap paper and a pencil. Think about the tasks the triggers needs to
-- PERFORM, INCLUDING CHECKING WHETHER THE NEW STOCK LEVEL FALLS BELOW THE REORDER POINT. IF SO,
-- check whether the product is already on order by viewing the product request table; if not,
-- ENTER A NEW PRODUCT REQUEST. TRY TO WRITE THE TRIGGER CODE ON PAPER. EVEN THOUGH YOU LEARN
-- a lot by reviewing code, you improve your skills faster when you create the code on
-- YOUR OWN.
-- 2. Open the c9reorder.txt file in the Chapter09 folder. Review this trigger code, and
-- DETERMINE HOW IT COMPARES WITH YOUR CODE.
-- 3. In SQL Developer, create the trigger with the provided code.
-- 4. Test the trigger with product ID 4. First, run the query shown in Figure 9-36 to verify the
-- CURRENT STOCK DATA FOR THIS PRODUCT. NOTICE THAT A SALE OF ONE MORE ITEM SHOULD INITIATE
-- a reorder.
-- SELECT
--   stock,
--   reorder
-- FROM
--   bb_product
-- WHERE
--   idProduct = 4;
-- FIGURE 9-36 Checking stock data
-- 5. Run the UPDATE statement shown in Figure 9-37. It should cause the trigger to fire. Notice
-- the query to check whether the trigger fired and whether a product stock request was
-- inserted in the BB_PRODUCT_REQUEST table.
-- UPDATE bb_product SET stock = 25
-- WHERE idProduct = 4;
-- SELECT *
-- FROM bb_product_request;
-- FIGURE 9-37 Updating the stock level for product 4
-- 6. Issue a ROLLBACK statement to undo these DML actions to restore data to its original state
-- for use in later assignments.
-- 7. Run the following statement to disable this trigger so that it doesn’t affect other projects:
-- ALTER TRIGGER bb_reorder_trg DISABLE;

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

SELECT
  stock,
  reorder
FROM
  bb_product
WHERE
  idProduct = 4;

UPDATE bb_product
SET
  stock = 25
WHERE
  idProduct = 4;

SELECT
  *
FROM
  bb_product_request;

ROLLBACK;

ALTER TRIGGER bb_reorder_trg DISABLE;
