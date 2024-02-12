-- Assignment 3-8: Using a Record Variable for Data Retrieval
-- The Brewbean’s application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET
-- table. Create a PL/SQL block with a record variable to retrieve this data and display it
-- onscreen. An initialized variable should provide the IDBASKET value. Test the block using
-- the basket ID 12.
DECLARE
  TYPE basket_rec_type IS RECORD (
    idbasket bb_basket.idbasket%TYPE,
    subtotal bb_basket.subtotal%TYPE,
    shipping bb_basket.shipping%TYPE,
    tax bb_basket.tax%TYPE,
    total bb_basket.total%TYPE
  );
  basket_rec  basket_rec_type;
  lv_idbasket bb_basket.idbasket%TYPE := 12;
BEGIN
  SELECT
    idbasket,
    subtotal,
    shipping,
    tax,
    total INTO basket_rec
  FROM
    bb_basket
  WHERE
    idbasket = lv_idbasket;
  DBMS_OUTPUT.PUT_LINE('IDBASKET: '
                       || basket_rec.idbasket);
  DBMS_OUTPUT.PUT_LINE('SUBTOTAL: '
                       || basket_rec.subtotal);
  DBMS_OUTPUT.PUT_LINE('SHIPPING: '
                       || basket_rec.shipping);
  DBMS_OUTPUT.PUT_LINE('TAX: '
                       || basket_rec.tax);
  DBMS_OUTPUT.PUT_LINE('TOTAL: '
                       || basket_rec.total);
END;
