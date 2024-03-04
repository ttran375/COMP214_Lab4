-- Assignment 6-5: Calculating Days Between Ordering and Shipping
-- An analyst in the quality assurance office reviews the time elapsed between receiving an order
-- and shipping the order. Any orders that haven’t been shipped within a day of the order being
-- placed are investigated. Create a function named ORD_SHIP_SF that calculates the number of
-- days between the basket’s creation date and the shipping date. The function should return a
-- character string that states OK if the order was shipped within a day or CHECK if it wasn’t. If the
-- order hasn’t shipped, return the string Not shipped. The IDSTAGE column of the
-- BB_BASKETSTATUS table indicates a shipped item with the value 5, and the DTSTAGE
-- column is the shipping date. The DTORDERED column of the BB_BASKET table is the order
-- date. Review data in the BB_BASKETSTATUS table, and create an anonymous block to test all
-- three outcomes the function should handle.
CREATE OR REPLACE FUNCTION ORD_SHIP_SF(
  p_basket_id IN NUMBER
) RETURN VARCHAR2 AS
  lv_ship_date  DATE;
  lv_order_date DATE;
  lv_days_diff  NUMBER;
  lv_status_id  NUMBER;
BEGIN
 -- Retrieve shipping date and order date
  SELECT
    bs.dtstage,
    b.dtordered,
    bs.idstage INTO lv_ship_date,
    lv_order_date,
    lv_status_id
  FROM
    bb_basketstatus bs
    JOIN bb_basket b
    ON bs.idbasket = b.idbasket
  WHERE
    b.idbasket = p_basket_id
    AND bs.idstage = 5; -- Assuming IDSTAGE 5 indicates shipped status
 -- If the order hasn't been shipped, return 'Not shipped'
  IF lv_ship_date IS NULL THEN
    RETURN 'Not shipped';
  ELSE
 -- Calculate days difference
    lv_days_diff := lv_ship_date - lv_order_date;
 -- If shipped within a day, return 'OK'
    IF lv_days_diff <= 1 THEN
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
  lv_result VARCHAR2(20);
BEGIN
 -- Test case 1: Order shipped within a day
  lv_result := ORD_SHIP_SF(3); -- Assuming basket ID 3
  DBMS_OUTPUT.PUT_LINE('Result for Basket 3: '
                       || lv_result);
 -- Test case 2: Order shipped after a day
  lv_result := ORD_SHIP_SF(4); -- Assuming basket ID 4
  DBMS_OUTPUT.PUT_LINE('Result for Basket 4: '
                       || lv_result);
 -- Test case 3: Order not yet shipped
  lv_result := ORD_SHIP_SF(7); -- Assuming basket ID 7
  DBMS_OUTPUT.PUT_LINE('Result for Basket 7: '
                       || lv_result);
END;
