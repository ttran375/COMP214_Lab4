-- Assignment 9-4: Updating Stock Levels When an Order Is Canceled
-- At times, customers make mistakes in submitting orders and call to cancel an order. Brewbean’s
-- wants to create a trigger that automatically updates the stock level of all products associated
-- with a canceled order and updates the ORDERPLACED column of the BB_BASKET table to
-- zero, reflecting that the order wasn’t completed. Create a trigger named BB_ORDCANCEL_TRG to
-- perform this task, taking into account the following points:
-- • The trigger needs to fire when a new status record is added to the
-- BB_BASKETSTATUS table and when the IDSTAGE column is set to 4,
-- which indicates an order has been canceled.
--  Each basket can contain multiple items in the BB_BASKETITEM table, so a
-- CURSOR FOR loop might be a suitable mechanism for updating each item’s stock
-- level.
-- • Keep in mind that coffee can be ordered in half or whole pounds.
-- • Use basket 6, which contains two items, for testing.
-- 1. Run this INSERT statement to test the trigger:
-- INSERT INTO bb_basketstatus (idStatus, idBasket, idStage, dtStage)
-- VALUES (bb_status_seq.NEXTVAL, 6, 4, SYSDATE);
-- 2. Issue queries to confirm that the trigger has modified the basket’s order status and product
-- stock levels correctly.
-- 3. Be sure to run the following statement to disable this trigger so that it doesn’t affect other
-- assignments:

CREATE OR REPLACE TRIGGER BB_ORDCANCEL_TRG AFTER
  INSERT ON bb_basketstatus FOR EACH ROW WHEN (NEW.idStage = 4)
DECLARE
  v_qty_ordered NUMBER;
BEGIN
 -- Retrieving the quantity ordered for the canceled order
  SELECT
    SUM(bi.Quantity) INTO v_qty_ordered
  FROM
    bb_basketitem bi
  WHERE
    bi.idBasket = :NEW.idBasket;
 -- Updating the stock levels of the products associated with the canceled order
  FOR item IN (
    SELECT
      bi.idProduct,
      SUM(bi.Quantity) AS total_quantity
    FROM
      bb_basketitem bi
    WHERE
      bi.idBasket = :NEW.idBasket
    GROUP BY
      bi.idProduct
  ) LOOP
    UPDATE bb_product
    SET
      stock = stock + item.total_quantity
    WHERE
      idProduct = item.idProduct;
  END LOOP;
 -- Updating ORDERPLACED column of BB_BASKET table to zero
  UPDATE bb_basket
  SET
    orderplaced = 0
  WHERE
    idBasket = :NEW.idBasket;
END;
/

INSERT INTO bb_basketstatus (
  idStatus,
  idBasket,
  idStage,
  dtStage
) VALUES (
  bb_status_seq.NEXTVAL,
  6,
  4,
  SYSDATE
);

ALTER TRIGGER BB_REQFILL_TRG DISABLE;
