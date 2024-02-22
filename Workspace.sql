-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE STATUS_SHIP_SP (
  p_basket_id IN NUMBER,
  p_date_shipped IN DATE,
  p_shipper IN VARCHAR2,
  p_tracking_number IN VARCHAR2
) AS
BEGIN
  INSERT INTO BB_BASKETSTATUS (
    IDBASKETSTATUS,
    IDBASKET,
    IDSTAGE,
    DTEVENT,
    COMMENTS
  ) VALUES (
    BB_STATUS_SEQ.NEXTVAL,
    p_basket_id,
    3,
    p_date_shipped,
    'Shipped via '
    || p_shipper
    || ', Tracking Number: '
    || p_tracking_number
  );
  COMMIT;
END;
/

-- Step 2: Test the procedure with the provided information
BEGIN
  STATUS_SHIP_SP(3, TO_DATE('20-FEB-12', 'DD-MON-YY'), 'UPS', 'ZW2384YXK4957');
END;
/
