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

CREATE OR REPLACE PACKAGE DISC_PKG AS
  pv_disc_num NUMBER := 0; -- Packaged variable to store the count of orders
  pv_disc_txt VARCHAR2(1) := 'N'; -- Packaged variable to indicate whether a discount should be applied
END DISC_PKG;
/

CREATE OR REPLACE TRIGGER BB_DISCOUNT_TRG AFTER
  UPDATE OF ORDERPLACED ON bb_basket FOR EACH ROW
BEGIN
  IF :NEW.ORDERPLACED = 1 THEN
    IF DISC_PKG.pv_disc_num = 5 THEN
      DISC_PKG.pv_disc_txt := 'Y';
    END IF;
  END IF;
END;
/

DECLARE
  v_dummy NUMBER;
BEGIN
  DISC_PKG.pv_disc_num := 5; -- Set the count of orders to 5 for testing
  DISC_PKG.pv_disc_txt := 'N'; -- Reset the discount indicator variable
  SELECT
    1 INTO v_dummy
  FROM
    dual
  WHERE
    DISC_PKG.pv_disc_txt = 'Y'; -- This will raise an exception if the trigger sets pv_disc_txt to 'Y'
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL; -- This is expected if the trigger does not set pv_disc_txt to 'Y'
END;
/

UPDATE bb_basket
SET
  orderplaced = 1
WHERE
  idBasket = 13;

ALTER TRIGGER BB_DISCOUNT_TRG DISABLE;
