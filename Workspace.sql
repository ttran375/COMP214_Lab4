CREATE OR REPLACE FUNCTION ORD_SHIP_SF(
  p_basket_id IN NUMBER
) RETURN VARCHAR2 AS
  v_ship_date  DATE;
  v_order_date DATE;
  v_days_diff  NUMBER;
  v_status_id  NUMBER;
BEGIN
 -- Retrieve shipping date and order date
  SELECT
    bs.dtstage,
    b.dtordered,
    bs.idstage INTO v_ship_date,
    v_order_date,
    v_status_id
  FROM
    bb_basketstatus bs
    JOIN bb_basket b
    ON bs.idbasket = b.idbasket
  WHERE
    b.idbasket = p_basket_id
    AND bs.idstage = 5; -- Assuming IDSTAGE 5 indicates shipped status
 -- If the order hasn't been shipped, return 'Not shipped'
  IF v_ship_date IS NULL THEN
    RETURN 'Not shipped';
  ELSE
 -- Calculate days difference
    v_days_diff := v_ship_date - v_order_date;
 -- If shipped within a day, return 'OK'
    IF v_days_diff <= 1 THEN
      RETURN 'OK';
    ELSE
      RETURN 'CHECK';
    END IF;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'No such basket found';
END;
/

-- Anonymous block to test the function
DECLARE
  v_result VARCHAR2(20);
BEGIN
 -- Test case 1: Order shipped within a day
  v_result := ORD_SHIP_SF(3); -- Assuming basket ID 3
  DBMS_OUTPUT.PUT_LINE('Result for Basket 3: '
                       || v_result);
 -- Test case 2: Order shipped after a day
  v_result := ORD_SHIP_SF(4); -- Assuming basket ID 4
  DBMS_OUTPUT.PUT_LINE('Result for Basket 4: '
                       || v_result);
 -- Test case 3: Order not yet shipped
  v_result := ORD_SHIP_SF(7); -- Assuming basket ID 7
  DBMS_OUTPUT.PUT_LINE('Result for Basket 7: '
                       || v_result);
END;
/
