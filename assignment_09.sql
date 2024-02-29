-- Assignment 2-9: Using a FOR Loop
-- Create a PL/SQL block using a FOR loop to generate a payment schedule for a donor’s pledge,
-- which is to be paid monthly in equal increments. Values available for the block are starting
-- payment due date, monthly payment amount, and number of total monthly payments for the
-- pledge. The list that’s generated should display a line for each monthly payment showing
-- payment number, date due, payment amount, and donation balance (remaining amount of
-- pledge owed).

DECLARE
    lv_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    lv_monthly_payment NUMBER := 1000;
    lv_total_payments NUMBER := 12;
    lv_balance NUMBER := lv_monthly_payment * lv_total_payments;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Payment# | Due Date   | Payment Amount | Donation Balance');

    FOR payment_number IN 1..lv_total_payments LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(payment_number, 9) ||
            ' | ' || TO_CHAR(lv_start_date, 'YYYY-MM-DD') ||
            ' | ' || lv_monthly_payment ||
            ' | ' || lv_balance
        );
        lv_start_date := ADD_MONTHS(lv_start_date, 1);
        lv_balance := lv_balance - lv_monthly_payment;
    END LOOP;
END;
