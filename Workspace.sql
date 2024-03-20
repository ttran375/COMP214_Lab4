-- Assignment 9-6: Using Triggers to Maintain Referential Integrity
-- At times, Brewbean’s has changed the ID numbers for existing products. In the past, developers
-- had to add a new product row with the new ID to the BB_PRODUCT table, modify all the
-- corresponding BB_BASKETITEM and BB_PRODUCTOPTION table rows, and then delete the
-- original product row. Can a trigger be developed to avoid all these steps and handle the update
-- of the BB_BASKETITEM and BB_PRODUCTOPTION table rows automatically for a change in
-- product ID? If so, create the trigger and test it by issuing an UPDATE statement that changes the
-- IDPRODUCT 7 to 22. Do a rollback to return the data to its original state, and disable the new
-- trigger after you have finished this assignment.

CREATE OR REPLACE TRIGGER trg_update_product_id BEFORE
  UPDATE OF idProduct ON BB_PRODUCT FOR EACH ROW
BEGIN
 -- Update BB_BASKETITEM table
  UPDATE BB_BASKETITEM
  SET
    idProduct = :NEW.idProduct
  WHERE
    idProduct = :OLD.idProduct;
 -- Update BB_PRODUCTOPTION table
  UPDATE BB_PRODUCTOPTION
  SET
    idProduct = :NEW.idProduct
  WHERE
    idProduct = :OLD.idProduct;
END;
/

UPDATE BB_PRODUCT
SET
  idProduct = 22
WHERE
  idProduct = 7;

ROLLBACK;

ALTER TRIGGER trg_update_product_id DISABLE;
