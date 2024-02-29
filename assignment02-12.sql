-- Assignment 2-12: Using a CASE Expression
-- Donors can select one of three payment plans for a pledge indicated by the following codes:
-- 0 = one-time (lump sum) payment, 1 = monthly payments over one year, and 2 = monthly
-- payments over two years. A local business has agreed to pay matching amounts on pledge
-- payments during the current month. A PL/SQL block is needed to identify the matching
-- amount for a pledge payment. Create a block using input values of a payment plan code
-- and a payment amount. Use a CASE expression to calculate the matching amount, based on
-- the payment plan codes 0 = 25%, 1 = 50%, 2 = 100%, and other = 0. Display the
-- calculated amount.

DECLARE
    lv_payment_plan_code NUMBER := 1;
    lv_payment_amount NUMBER := 1000;
    lv_matching_amount NUMBER;
BEGIN
    lv_matching_amount := 
        CASE lv_payment_plan_code
            WHEN 0 THEN lv_payment_amount * 0.25
            WHEN 1 THEN lv_payment_amount * 0.50
            WHEN 2 THEN lv_payment_amount * 1.00
            ELSE 0
        END;

    DBMS_OUTPUT.PUT_LINE('Payment Plan Code: ' || lv_payment_plan_code);
    DBMS_OUTPUT.PUT_LINE('Payment Amount: ' || lv_payment_amount);
    DBMS_OUTPUT.PUT_LINE('Calculated Matching Amount: ' || lv_matching_amount);
END;
