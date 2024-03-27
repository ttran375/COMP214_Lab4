-- Assignment 9-7: Updating Summary Data Tables
-- The Brewbean’s owner uses several summary sales data tables every day to monitor business
-- activity. The BB_SALES_SUM table holds the product ID, total sales in dollars, and total
-- quantity sold for each product. A trigger is needed so that every time an order is confirmed or
-- the ORDERPLACED column is updated to 1, the BB_SALES_SUM table is updated
-- accordingly. Create a trigger named BB_SALESUM_TRG that performs this task. Before testing,
-- reset the ORDERPLACED column to 0 for basket 3, as shown in the following code, and use
-- this basket to test the trigger:
-- UPDATE bb_basket
-- SET orderplaced = 0
-- WHERE idBasket = 3;
-- Notice that the BB_SALES_SUM table already contains some data. Test the trigger with
-- the following UPDATE statement, and confirm that the trigger is working correctly:
-- UPDATE bb_basket
-- SET orderplaced = 1
-- WHERE idBasket = 3;
-- Do a rollback and disable the trigger when you’re finished so that it doesn’t affect other
-- assignments.
CREATE TABLE BB_SALES_SUM (
  idProduct NUMBER(2),
  TotalSales NUMBER(6, 2),
  TotalQtySold NUMBER(5)
);

ALTER TABLE BB_SALES_SUM ADD CONSTRAINT pk_bb_sales_sum PRIMARY KEY (idProduct);

UPDATE bb_basket
SET
  orderplaced = 0
WHERE
  idBasket = 3;

CREATE OR REPLACE TRIGGER BB_SALESUM_TRG AFTER
  UPDATE OF orderplaced ON bb_basket FOR EACH ROW WHEN (NEW.orderplaced = 1)
BEGIN
  FOR cur IN (
    SELECT
      idProduct,
      SUM(Price * Quantity) AS TotalSales,
      SUM(Quantity)         AS TotalQty
    FROM
      bb_basketItem
    WHERE
      idBasket = :NEW.idBasket
    GROUP BY
      idProduct
  ) LOOP
    UPDATE BB_SALES_SUM
    SET
      TotalSales = TotalSales + cur.TotalSales,
      TotalQtySold = TotalQtySold + cur.TotalQty
    WHERE
      idProduct = cur.idProduct;
    IF SQL%NOTFOUND THEN
      INSERT INTO BB_SALES_SUM (
        idProduct,
        TotalSales,
        TotalQtySold
      ) VALUES (
        cur.idProduct,
        cur.TotalSales,
        cur.TotalQty
      );
    END IF;
  END LOOP;
END;
/

UPDATE bb_basket
SET
  orderplaced = 1
WHERE
  idBasket = 3;

ROLLBACK;

ALTER TRIGGER BB_SALESUM_TRG DISABLE;
