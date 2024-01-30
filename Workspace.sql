CREATE OR REPLACE PROCEDURE CalculateTotalPaymentForPledge(p_pledge_id IN NUMBER, p_total_payment OUT NUMBER) AS
BEGIN
    SELECT NVL(SUM(Payamt), 0)
    INTO p_total_payment
    FROM DD_Payment
    WHERE idPledge = p_pledge_id;
END CalculateTotalPaymentForPledge;
/
