CREATE OR REPLACE FUNCTION dollar_fmt_sf (
  p_num NUMBER
) RETURN VARCHAR2 IS
  lv_amt_txt VARCHAR2(20);
BEGIN
  lv_amt_txt := TO_CHAR(p_num, '$99,999.99');
  RETURN lv_amt_txt;
END;
/

DECLARE
  lv_amt_num NUMBER(8, 2) := 9999.55;
BEGIN
  DBMS_OUTPUT.PUT_LINE(dollar_fmt_sf(lv_amt_num));
END;
/

SELECT
  dollar_fmt_sf(shipping),
  dollar_fmt_sf(total)
FROM
  bb_basket
WHERE
  idBasket = 3;
