-- Assignment 3-7: Using Scalar Variables for Data Retrieval
-- The Brewbean’s application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET
-- table. Create a PL/SQL block with scalar variables to retrieve this data and then display it
-- onscreen. An initialized variable should provide the IDBASKET value. Test the block using the
-- basket ID 12.
DECLARE
  lv_idbasket bb_basket.idbasket%TYPE := 12;
  lv_subtotal bb_basket.subtotal%TYPE;
  lv_shipping bb_basket.shipping%TYPE;
  lv_tax      bb_basket.tax%TYPE;
  lv_total    bb_basket.total%TYPE;
BEGIN
  SELECT
    subtotal,
    shipping,
    tax,
    total INTO lv_subtotal,
    lv_shipping,
    lv_tax,
    lv_total
  FROM
    bb_basket
  WHERE
    idbasket = lv_idbasket;
  DBMS_OUTPUT.PUT_LINE('IDBASKET: '
                       || lv_idbasket);
  DBMS_OUTPUT.PUT_LINE('SUBTOTAL: '
                       || lv_subtotal);
  DBMS_OUTPUT.PUT_LINE('SHIPPING: '
                       || lv_shipping);
  DBMS_OUTPUT.PUT_LINE('TAX: '
                       || lv_tax);
  DBMS_OUTPUT.PUT_LINE('TOTAL: '
                       || lv_total);
END;
