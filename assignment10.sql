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
-- Stock level currently
-- below reorder level
-- Current request for
-- a quantity of 45
-- FIGURE 9-38 Querying the data for product 5 stock and reorder amount
-- An UPDATE statement
-- that records receiving a
-- request res the trigger.
-- Order received
-- Stock level increased
-- FIGURE 9-39 Updating the product request
-- 4. Now update the product request to record it as fulfilled by using the UPDATE statement
-- shown in Figure 9-39.
-- 5. Issue queries to verify that the trigger fired and the stock level of product 5 has been
-- modified correctly. Then issue a ROLLBACK statement to undo the modifications.
-- 6. If you aren’t doing Assignment 9-3, disable the trigger so that it doesn’t affect
-- other assignments.
-- create product request
INSERT INTO bb_product_request (
  idrequest,
  idproduct,
  dtrequest,
  qty
) VALUES (
  3,
  5,
  sysdate,
  45
);

/

-- Creat trigger to handle updating stock
CREATE OR REPLACE TRIGGER bb_reqfill_trg AFTER
  UPDATE OF dtrecd ON bb_product_request FOR EACH ROW
BEGIN
 /* update bb_product and set stock equal to
      the new qty (from bb_product_update) plus
      the old stock, where the id equals the
      id referenced by the update that fired 
      the trigger. */
  UPDATE bb_product
  SET
    stock = :new.qty + stock
  WHERE
    idproduct = :new.idproduct;
END;
/

-- show that product 5 is below reorder amount
SELECT
  stock,
  reorder
FROM
  bb_product
WHERE
  idproduct = 5;

/

-- Show that 5 is currently up for reorder
SELECT
  idproduct,
  idrequest,
  dtrequest,
  cost,
  qty
FROM
  bb_product_request;

/

-- Do update and fire trigger
UPDATE bb_product_request
SET
  dtrecd = sysdate,
  cost = 225
WHERE
  idproduct = 5;

/

-- show that order was fulfilled
SELECT
  idproduct,
  idrequest,
  dtrequest,
  cost,
  qty
FROM
  bb_product_request;

/

-- show that trigger fired and stock was updated
SELECT
  stock,
  reorder
FROM
  bb_product
WHERE
  idproduct = 5;

/

-- Undo all our effort
ROLLBACK;

-- DROP TRIGGER bb_reqfill_trg;

/

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
CREATE OR REPLACE TRIGGER BB_REQFILL_TRG AFTER
  UPDATE OF DTRECD ON BB_PRODUCT_REQUEST FOR EACH ROW
DECLARE
  v_qty NUMBER;
BEGIN
  IF :OLD.DTRECD IS NOT NULL AND :NEW.DTRECD IS NULL THEN
 -- Product request is being marked as not filled
 -- Adjust the product stock level
    SELECT
      qty INTO v_qty
    FROM
      bb_product_request
    WHERE
      idRequest = :OLD.idRequest;
    UPDATE bb_product
    SET
      stock = stock + v_qty
    WHERE
      idProduct = :OLD.idProduct;
  END IF;
END;
/

ALTER TRIGGER BB_REQFILL_TRG DISABLE;

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
-- ALTER TRIGGER bb_ordcancel_trg DISABLE;
-- Assignment 9-5: Processing Discounts
-- Brewbean’s is offering a new discount for return shoppers: Every fifth completed order gets a
-- 10% discount. The count of orders for a shopper is placed in a packaged variable named
-- pv_disc_num during the ordering process. This count needs to be tested at checkout to
-- determine whether a discount should be applied. Create a trigger named BB_DISCOUNT_TRG
-- so that when an order is confirmed (the ORDERPLACED value is changed from 0 to 1), the
-- pv_disc_num packaged variable is checked. If it’s equal to 5, set a second variable named
-- pv_disc_txt to Y. This variable is used in calculating the order summary so that a discount is
-- applied, if necessary.
-- Create a package specification named DISC_PKG containing the necessary packaged
-- variables. Use an anonymous block to initialize the packaged variables to use for testing the
-- trigger. Test the trigger with the following UPDATE statement:
-- UPDATE bb_basket
-- SET orderplaced = 1
-- WHERE idBasket = 13;
-- If you need to test the trigger multiple times, simply reset the ORDERPLACED column to 0
-- for basket 13 and then run the UPDATE again. Also, disable this trigger when you’re finished so
-- that it doesn’t affect other assignments.
-- Assignment 9-6: Using Triggers to Maintain Referential Integrity
-- At times, Brewbean’s has changed the ID numbers for existing products. In the past, developers
-- had to add a new product row with the new ID to the BB_PRODUCT table, modify all the
-- corresponding BB_BASKETITEM and BB_PRODUCTOPTION table rows, and then delete the
-- original product row. Can a trigger be developed to avoid all these steps and handle the update
-- of the BB_BASKETITEM and BB_PRODUCTOPTION table rows automatically for a change in
-- product ID? If so, create the trigger and test it by issuing an UPDATE statement that changes the
-- IDPRODUCT 7 to 22. Do a rollback to return the data to its original state, and disable the new
-- trigger after you have finished this assignment.
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
-- Assignment 9-8: Maintaining an Audit Trail of Product Table Changes
-- The accuracy of product table data is critical, and the Brewbean’s owner wants to have an audit
-- file containing information on all DML activity on the BB_PRODUCT table. This information
-- should include the ID of the user performing the DML action, the date, the original values of the
-- changed row, and the new values. This audit table needs to track specific columns of concern,
-- including PRODUCTNAME, PRICE, SALESTART, SALEEND, and SALEPRICE. Create a table
-- named BB_PRODCHG_AUDIT to hold the relevant data, and then create a trigger named
-- BB_AUDIT_TRG that fires an update to this table whenever a specified column in the
-- BB_PRODUCT table changes.
-- TIP
-- Multiple columns can be listed in a trigger’s OF clause by separating them with commas.
-- Be sure to issue the following command. If you created the SALES_DATE_TRG trigger in the
-- chapter, it conflicts with this assignment.
-- ALTER TRIGGER sales_date_trg DISABLE;
-- Use the following UPDATE statement to test the trigger:
-- UPDATE bb_product
-- SET salestart = '05-MAY-2012',
-- saleend = '12-MAY-2012'
-- saleprice = 9
-- WHERE idProduct = 10;
-- When you’re finished, do a rollback and disable the trigger so that it doesn’t affect other
-- assignments.
-- Hands-On Assignments Part II
-- Assignment 9-9: Tracking Pledge Payment Activity
-- The DoGood Donor organization wants to track all pledge payment activity. Each time a pledge
-- payment is added, changed, or removed, the following information should be captured in a
-- separate table: username (logon), current date, action taken (INSERT, UPDATE, or DELETE),
-- and the idpay value for the payment record. Create a table named DD_PAYTRACK to hold
-- this information. Include a primary key column to be populated by a sequence, and create a
-- new sequence named DD_PTRACK_SEQ for the primary key column. Create a single trigger for
-- recording the requested information to track pledge payment activity, and test the trigger.
-- Assignment 9-10: Identifying First Pledges
-- The DD_PLEDGE table contains the FIRSTPLEDGE column that indicates whether a pledge is
-- the donor’s first pledge. The DoGood Donor organization wants this identification to be
-- automated. Create a trigger that adds the corresponding data to the FIRSTPLEDGE column
-- when a new pledge is added, and test the trigger.
-- Case Projects
-- Case 9-1: Mapping the Flow of Database Triggers
-- After you learn how to create triggers, you realize that one statement can end up firing off a
-- number of triggers. Not only can you have multiple triggers attached to a single table, but also a
-- trigger can perform DML operations that might affect other tables and fire off other triggers. To
-- prevent this problem, you might be able to combine triggers to make your code clearer and
-- easier to maintain. For example, if you have one trigger for an INSERT statement on the
-- BB_PRODUCT table and another for an UPDATE statement on the BB_PRODUCT table, you
-- might want to combine them into one trigger and use conditional predicates. In addition, triggers
-- that run DML statements that could fire off additional triggers could lead to a mutating table
-- error. However, this error might not be apparent unless you identify the flow of trigger
-- processing and associated objects.
-- Review the CREATE TRIGGER statements in the c9case1.txt file in the Chapter09 folder.
-- Prepare a flowchart illustrating which triggers will fire and the firing sequence if a user logs on
-- and issues the following code:
-- UPDATE bb_product
-- SET stock = 50
-- WHERE idProduct = 3;
-- Case 9-2: Processing Inventory for More Movies
-- The More Movies company needs to make sure the quantity of each movie is updated for each
-- rental recorded and returned. The MM_MOVIE table contains the MOVIE_QTY column that
-- reflects the current number of copies in stock for a movie. Create triggers that update the
-- MOVIE_QTY column for rentals (named MM_RENT_TRG) and returns (named MM_RETURN_TRG).
-- Test your triggers with the following DML actions, which add a rental and update it to reflect that
-- it has been returned. Issue queries to confirm that the triggers fired and worked correctly.
-- INSERT INTO mm_rental (rental_id, member_id, movie_id,
-- payment_methods_id)
-- VALUES (13, 10, 6, 2);
-- UPDATE mm_rental
-- SET checkin_date = SYSDATE
-- WHERE rental_id = 13;
