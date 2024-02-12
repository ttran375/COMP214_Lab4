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
  lv_basket_rec basket_rec_type;
  lv_idbasket   bb_basket.idbasket%TYPE := 12;
BEGIN
  SELECT
    idbasket,
    subtotal,
    shipping,
    tax,
    total INTO lv_basket_rec
  FROM
    bb_basket
  WHERE
    idbasket = lv_idbasket;
  DBMS_OUTPUT.PUT_LINE('IDBASKET: '
                       || lv_basket_rec.idbasket);
  DBMS_OUTPUT.PUT_LINE('SUBTOTAL: '
                       || lv_basket_rec.subtotal);
  DBMS_OUTPUT.PUT_LINE('SHIPPING: '
                       || lv_basket_rec.shipping);
  DBMS_OUTPUT.PUT_LINE('TAX: '
                       || lv_basket_rec.tax);
  DBMS_OUTPUT.PUT_LINE('TOTAL: '
                       || lv_basket_rec.total);
END;
