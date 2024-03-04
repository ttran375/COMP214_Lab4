SET SERVEROUTPUT ON;

-- Create the ORD_SHIP_SF function
CREATE OR REPLACE FUNCTION ORD_SHIP_SF(
  p_basket_id IN NUMBER
) RETURN VARCHAR2 IS
  v_order_date DATE;
  v_ship_date  DATE;
  v_status_id  NUMBER;
  v_days_diff  NUMBER;
BEGIN
 -- Get the order date
  SELECT
    DTORDERED INTO v_order_date
  FROM
    BB_BASKET
  WHERE
    BASKET_ID = p_basket_id;
 -- Get the shipping date and status
  SELECT
    DTSTAGE,
    IDSTAGE INTO v_ship_date,
    v_status_id
  FROM
    BB_BASKETSTATUS
  WHERE
    BASKET_ID = p_basket_id
    AND ROWNUM = 1
  ORDER BY
    DTSTAGE DESC;
 -- Calculate the days difference
  v_days_diff := v_ship_date - v_order_date;
 -- Check if shipped within a day
  IF v_status_id = 5 THEN
    IF v_days_diff <= 1 THEN
      RETURN 'OK';
    ELSE
      RETURN 'CHECK';
    END IF;
  ELSE
    RETURN 'Not shipped';
  END IF;
END ORD_SHIP_SF;
/

-- Test the function with different scenarios
DECLARE
  v_basket_id1 NUMBER := 1; -- Shipped within a day
  v_basket_id2 NUMBER := 2; -- Shipped after a day
  v_basket_id3 NUMBER := 3; -- Not shipped
  v_result1    VARCHAR2(20);
  v_result2    VARCHAR2(20);
  v_result3    VARCHAR2(20);
BEGIN
 -- Test case 1: Shipped within a day
  v_result1 := ORD_SHIP_SF(v_basket_id1);
  DBMS_OUTPUT.PUT_LINE('Test Case 1 Result: '
                       || v_result1);
 -- Test case 2: Shipped after a day
  v_result2 := ORD_SHIP_SF(v_basket_id2);
  DBMS_OUTPUT.PUT_LINE('Test Case 2 Result: '
                       || v_result2);
 -- Test case 3: Not shipped
  v_result3 := ORD_SHIP_SF(v_basket_id3);
  DBMS_OUTPUT.PUT_LINE('Test Case 3 Result: '
                       || v_result3);
END;
/
