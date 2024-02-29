-- Assignment 5-3: Calculating the Tax on an Order
-- Follow these steps to create a procedure for calculating the tax on an order. The BB_TAX table
-- contains states that require submitting taxes for Internet sales. If the state isn’t listed in the
-- table, no tax should be assessed on the order. The shopper’s state and basket subtotal are the
-- inputs to the procedure, and the tax amount should be returned.
-- 1. In SQL Developer, create a procedure named TAX_COST_SP. Remember that the state
-- and subtotal values are inputs to the procedure, which should return the tax amount.
-- Review the BB_TAX table, which contains the tax rate for each applicable state.
-- 2. Call the procedure with the values VA for the state and $100 for the subtotal. Display the
-- tax amount the procedure returns. (It should be $4.50.)

-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE TAX_COST_SP (
  p_state IN VARCHAR2,
  p_subtotal IN NUMBER,
  p_tax OUT NUMBER
) AS
BEGIN
  SELECT
    TaxRate INTO p_tax
  FROM
    bb_tax
  WHERE
    State = p_state;
  IF p_tax IS NULL THEN
    p_tax := 0;
  ELSE
    p_tax := p_subtotal * p_tax;
  END IF;
END TAX_COST_SP;
/

-- Step 2: Call the procedure with the specified parameter values
DECLARE
  lv_state    VARCHAR2(2) := 'VA';
  lv_subtotal NUMBER := 100;
  lv_tax      NUMBER;
BEGIN
  TAX_COST_SP(lv_state, lv_subtotal, lv_tax);
  DBMS_OUTPUT.PUT_LINE('Tax Amount: $'
                       || TO_CHAR(lv_tax, '999.99'));
END;
