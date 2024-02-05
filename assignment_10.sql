-- Assignment 2-10: Using a Basic Loop
-- Accomplish the task in Assignment 2-9 by using a basic loop structure.
DECLARE
    lv_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    lv_monthly_payment NUMBER := 1000;
    lv_total_payments NUMBER := 12;
    lv_balance NUMBER := lv_monthly_payment * lv_total_payments;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Payment# | Due Date   | Payment Amount | Donation Balance');

    LOOP
        EXIT WHEN lv_total_payments = 0;

        DBMS_OUTPUT.PUT_LINE(
            RPAD(lv_total_payments, 9) ||
            ' | ' || TO_CHAR(lv_start_date, 'YYYY-MM-DD') ||
            ' | ' || lv_monthly_payment ||
            ' | ' || lv_balance
        );

        lv_start_date := ADD_MONTHS(lv_start_date, 1);
        lv_balance := lv_balance - lv_monthly_payment;
        lv_total_payments := lv_total_payments - 1;
    END LOOP;
END;
/
