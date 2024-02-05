-- Assignment 2-5: Using a Boolean Variable
-- Brewbean’s needs program code to indicate whether an amount is still due on an account when a payment is received. Create a PL/SQL block using a Boolean variable to indicate whether an amount is still due. Declare and initialize two variables to provide input for the account balance and the payment amount received. A TRUE Boolean value should indicate an amount is still owed, and a FALSE value should indicate the account is paid in full. Use output statements to confirm that the Boolean variable is working correctly.
DECLARE
  vAccountBalance NUMBER := 1000; -- Initialize with the account balance
  vPaymentReceived NUMBER := 500; -- Initialize with the payment amount received
  vAmountDue BOOLEAN; -- Boolean variable to indicate whether an amount is still due
BEGIN
  -- Check if there is still an amount due
  IF vPaymentReceived < vAccountBalance THEN
    vAmountDue := TRUE; -- Set to TRUE if amount is still due
  ELSE
    vAmountDue := FALSE; -- Set to FALSE if account is paid in full
  END IF;

  DBMS_OUTPUT.PUT_LINE('Account Balance: ' || vAccountBalance);
  DBMS_OUTPUT.PUT_LINE('Payment Received: ' || vPaymentReceived);
  -- Output statements to confirm the Boolean variable
  IF vAmountDue THEN
    DBMS_OUTPUT.PUT_LINE('Amount is still due on the account.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Account is paid in full.');
  END IF;
END;
/
