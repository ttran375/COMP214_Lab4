-- Assignment 2-9: Using a FOR Loop
-- Create a PL/SQL block using a FOR loop to generate a payment schedule for a donor’s pledge, which is to be paid monthly in equal increments. Values available for the block are starting payment due date, monthly payment amount, and number of total monthly payments for the pledge. The list that’s generated should display a line for each monthly payment showing payment number, date due, payment amount, and donation balance (remaining amount of pledge owed).
DECLARE
    v_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD'); -- Starting payment due date
    v_monthly_payment NUMBER := 1000; -- Monthly payment amount
    v_total_payments NUMBER := 12; -- Total number of monthly payments

    v_balance NUMBER := v_monthly_payment * v_total_payments; -- Initial balance

BEGIN
    -- Display header
    DBMS_OUTPUT.PUT_LINE('Payment# | Due Date   | Payment Amount | Donation Balance');

    -- Generate payment schedule using FOR loop
    FOR payment_number IN 1..v_total_payments LOOP

    -- Display payment details
        DBMS_OUTPUT.PUT_LINE(
            RPAD(payment_number, 9) ||
            ' | ' || TO_CHAR(v_start_date, 'YYYY-MM-DD') ||
            ' | ' || v_monthly_payment ||
            ' | ' || v_balance
        );
        -- Calculate next due date
        v_start_date := ADD_MONTHS(v_start_date, 1);

        

        -- Update remaining balance
        v_balance := v_balance - v_monthly_payment;
    END LOOP;
END;
/
