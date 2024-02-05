-- Assignment 2-5: Using a Boolean Variable
-- Brewbean’s needs program code to indicate whether an amount is still due on an account when a payment is received. Create a PL/SQL block using a Boolean variable to indicate whether an amount is still due. Declare and initialize two variables to provide input for the account balance and the payment amount received. A TRUE Boolean value should indicate an amount is still owed, and a FALSE value should indicate the account is paid in full. Use output statements to confirm that the Boolean variable is working correctly.
DECLARE
    lv_account_balance NUMBER := 1000; -- Initialize with the account balance
    lv_payment_received NUMBER := 500; -- Initialize with the payment amount received
    lv_amount_due BOOLEAN; -- Boolean variable to indicate whether an amount is still due
BEGIN
    IF lv_payment_received < lv_account_balance THEN
        lv_amount_due := TRUE;
    ELSE
        lv_amount_due := FALSE;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Account Balance: ' || lv_account_balance);
    DBMS_OUTPUT.PUT_LINE('Payment Received: ' || lv_payment_received);

    IF lv_amount_due THEN
        DBMS_OUTPUT.PUT_LINE('Amount is still due on the account.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account is paid in full.');
    END IF;
END;
/
