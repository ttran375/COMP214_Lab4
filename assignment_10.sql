-- Assignment 2-10: Using a Basic Loop
-- Accomplish the task in Assignment 2-9 by using a basic loop structure.
DECLARE
    v_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD'); -- Starting payment due date
    v_monthly_payment NUMBER := 1000; -- Monthly payment amount
    v_total_payments NUMBER := 12; -- Total number of monthly payments

    v_balance NUMBER := v_monthly_payment * v_total_payments; -- Initial balance
    payment_number NUMBER := 1; -- Initialize payment number

BEGIN
    -- Display header
    DBMS_OUTPUT.PUT_LINE('Payment# | Due Date   | Payment Amount | Donation Balance');

    -- Generate payment schedule using basic loop
    LOOP
        EXIT WHEN payment_number > v_total_payments;

        -- Calculate next due date
        v_start_date := ADD_MONTHS(TO_DATE('2024-01-01', 'YYYY-MM-DD'), payment_number - 1);

        -- Display payment details
        DBMS_OUTPUT.PUT_LINE(
            RPAD(payment_number, 9) ||
            ' | ' || TO_CHAR(v_start_date, 'YYYY-MM-DD') ||
            ' | ' || v_monthly_payment ||
            ' | ' || v_balance
        );

        -- Update remaining balance
        v_balance := v_balance - v_monthly_payment;

        -- Increment payment number
        payment_number := payment_number + 1;
    END LOOP;
END;
/
