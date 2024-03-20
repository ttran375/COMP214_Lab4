-- Assignment 7-11: Adding a Payment Retrieval Procedure to the Package
-- Modify the package created in Assignment 7-10 as follows:
-- • Add a new procedure named DD_PAYS_PP that retrieves donor pledge payment
-- information and returns all the required data via a single parameter.
-- • A donor ID is the input for the procedure.
-- • The procedure should retrieve the donor’s last name and each pledge payment
-- made so far (including payment amount and payment date).
-- • Make the procedure public.
-- Test the procedure with an anonymous block. The procedure call must handle the data
-- being returned by means of a single parameter in the procedure. For each pledge payment,
-- make sure the pledge ID, donor’s last name, pledge payment amount, and pledge payment
-- date are displayed.
CREATE OR REPLACE TYPE payment_info_record AS
  OBJECT (
    idPledge NUMBER,
    lastname VARCHAR2(30),
    payamt NUMBER(8, 2),
    paydate VARCHAR2(20)
  );
/

CREATE OR REPLACE TYPE payment_info_table AS
  TABLE OF payment_info_record;
/

CREATE OR REPLACE PROCEDURE DD_PAYS_PP (
  donorId IN NUMBER,
  paymentInfo OUT payment_info_table
) AS
BEGIN
 -- Initialize the output table
  paymentInfo := payment_info_table();
  FOR rec IN (
    SELECT
      p.idPledge,
      d.Lastname,
      pay.Payamt,
      pay.Paydate
    FROM
      DD_Donor   d
      JOIN DD_Pledge p
      ON d.idDonor = p.idDonor
      JOIN DD_Payment pay
      ON p.idPledge = pay.idPledge
    WHERE
      d.idDonor = donorId
  ) LOOP
 -- Extend the collection and populate it with fetched data
    paymentInfo.EXTEND;
    paymentInfo(paymentInfo.LAST) := payment_info_record(rec.idPledge, rec.lastname, rec.payamt, rec.paydate);
  END LOOP;
END;
/

DECLARE
  paymentData payment_info_table;
BEGIN
 -- Call the procedure with a donor ID, for example, 301
  DD_PAYS_PP(301, paymentData);
 -- Loop through the returned payment data and display each record
  FOR i IN 1..paymentData.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '
                         || paymentData(i).idPledge
                         || ', Last Name: '
                         || paymentData(i).lastname
                         || ', Payment Amount: '
                         || paymentData(i).payamt
                         || ', Payment Date: '
                         || paymentData(i).paydate);
  END LOOP;
END;
/
