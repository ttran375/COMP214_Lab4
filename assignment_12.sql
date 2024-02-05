-- Assignment 2-12: Using a CASE Expression
-- Donors can select one of three payment plans for a pledge indicated by the following codes: 0 = one-time (lump sum) payment, 1 = monthly payments over one year, and 2 = monthly payments over two years. A local business has agreed to pay matching amounts on pledge payments during the current month. A PL/SQL block is needed to identify the matching amount for a pledge payment. Create a block using input values of a payment plan code and a payment amount. Use a CASE expression to calculate the matching amount, based on the payment plan codes 0 = 25%, 1 = 50%, 2 = 100%, and other = 0. Display the calculated amount.
DECLARE
    v_payment_plan_code NUMBER := 1; -- Input: Payment plan code
    v_payment_amount NUMBER := 1000; -- Input: Payment amount
    v_matching_amount NUMBER; -- Calculated matching amount

BEGIN
    -- Calculate matching amount using CASE expression
    v_matching_amount := 
        CASE v_payment_plan_code
            WHEN 0 THEN v_payment_amount * 0.25 -- 25% matching for one-time payment
            WHEN 1 THEN v_payment_amount * 0.50 -- 50% matching for monthly payments over one year
            WHEN 2 THEN v_payment_amount * 1.00 -- 100% matching for monthly payments over two years
            ELSE 0 -- No matching for other payment plan codes
        END;

    DBMS_OUTPUT.PUT_LINE('Payment Plan Code: ' || v_payment_plan_code);
    DBMS_OUTPUT.PUT_LINE('Payment Amount: ' || v_payment_amount);
    DBMS_OUTPUT.PUT_LINE('Calculated Matching Amount: ' || v_matching_amount);
    
    

END;
/
