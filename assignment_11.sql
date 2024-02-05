-- Assignment 2-11: Using a WHILE Loop
-- Accomplish the task in Assignment 2-9 by using a WHILE loop structure. Instead of displaying the donation balance (remaining amount of pledge owed) on each line of output, display the total paid to date.
DECLARE
    v_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD'); -- Starting payment due date
    v_monthly_payment NUMBER := 1000; -- Monthly payment amount
    v_total_payments NUMBER := 12; -- Total number of monthly payments

    v_balance NUMBER := v_monthly_payment * v_total_payments; -- Initial balance
    v_total_paid NUMBER := 0; -- Initialize total paid to date
    payment_number NUMBER := 1; -- Initialize payment number

BEGIN
    -- Display header
    DBMS_OUTPUT.PUT_LINE('Payment# | Due Date   | Payment Amount | Total Paid to Date');

    -- Generate payment schedule using WHILE loop
    WHILE payment_number <= v_total_payments LOOP
    -- Update total paid to date
        v_total_paid := v_total_paid + v_monthly_payment;
        -- Calculate next due date
        v_start_date := ADD_MONTHS(TO_DATE('2024-01-01', 'YYYY-MM-DD'), payment_number - 1);

        -- Display payment details
        DBMS_OUTPUT.PUT_LINE(
            RPAD(payment_number, 9) ||
            ' | ' || TO_CHAR(v_start_date, 'YYYY-MM-DD') ||
            ' | ' || v_monthly_payment ||
            ' | ' || v_total_paid
        );

        -- Increment payment number
        payment_number := payment_number + 1;
    END LOOP;
END;
/
