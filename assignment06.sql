-- Assignment 6-6: Adding Descriptions for Order Status Codes
-- When a shopper returns to the Web site to check an order’s status, information from the
-- BB_BASKETSTATUS table is displayed. However, only the status code is available in the
-- BB_BASKETSTATUS table, not the status description. Create a function named STATUS_DESC_SF
-- that accepts a stage ID and returns the status description. The descriptions for stage IDs
-- are listed in Table 6-3. Test the function in a SELECT statement that retrieves all rows in the
-- BB_BASKETSTATUS table for basket 4 and displays the stage ID and its description.
-- Create the function STATUS_DESC_SF
CREATE OR REPLACE FUNCTION STATUS_DESC_SF(
  stage_id IN NUMBER
) RETURN VARCHAR2 IS
  status_desc VARCHAR2(100);
BEGIN
  CASE stage_id
    WHEN 1 THEN
      status_desc := 'Order submitted';
    WHEN 2 THEN
      status_desc := 'Accepted, sent to shipping';
    WHEN 3 THEN
      status_desc := 'Back-ordered';
    WHEN 4 THEN
      status_desc := 'Cancelled';
    WHEN 5 THEN
      status_desc := 'Shipped';
    ELSE
      status_desc := 'Unknown';
  END CASE;

  RETURN status_desc;
END STATUS_DESC_SF;
/

-- Test the function using a SELECT statement
SELECT
  bs.idStage,
  STATUS_DESC_SF(bs.idStage) AS Status_Description
FROM
  bb_basketstatus bs
WHERE
  bs.idBasket = 4;

-- Assignment 6-7: Calculating an Order’s Tax Amount
-- Create a function named TAX_CALC_SF that accepts a basket ID, calculates the tax amount
-- by using the basket subtotal, and returns the correct tax amount for the order. The tax is
-- determined by the shipping state, which is stored in the BB_BASKET table. The BB_TAX table
-- contains the tax rate for states that require taxes on Internet purchases. If the state isn’t listed
-- in the tax table or no shipping state is assigned to the basket, a tax amount of zero should be
-- applied to the order. Use the function in a SELECT statement that displays the shipping costs for
-- a basket that has tax applied and a basket with no shipping state.
-- TABLE 6-3 Basket Stage Descriptions
-- Stage ID Description
-- 1 Order submitted
-- 2 Accepted, sent to shipping
-- 3 Back-ordered
-- 4 Cancelled
-- 5 Shipped
-- Step 1: Define the function TAX_CALC_SF
CREATE OR REPLACE FUNCTION TAX_CALC_SF(
  basket_id IN NUMBER
) RETURN NUMBER AS
  tax_amount NUMBER(5, 2);
BEGIN
 -- Step 2: Calculate the tax based on the shipping state
  SELECT
    COALESCE(SUM(b.SubTotal * t.TaxRate), 0) INTO tax_amount
  FROM
    bb_basket b
    LEFT JOIN bb_tax t
    ON b.ShipState = t.State
  WHERE
    b.idBasket = basket_id;
  RETURN tax_amount;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END TAX_CALC_SF;
/

-- Step 3: Use the function in a SELECT statement
SELECT
  idBasket,
  SubTotal,
  TAX_CALC_SF(idBasket) AS TaxAmount,
  Shipping
FROM
  bb_basket;

-- Assignment 6-8: Identifying Sale Products
-- When a product is placed on sale, Brewbean’s records the sale’s start and end dates in
-- columns of the BB_PRODUCT table. A function is needed to provide sales information when a
-- shopper selects an item. If a product is on sale, the function should return the value ON SALE!.
-- However, if it isn’t on sale, the function should return the value Great Deal!. These values are
-- used on the product display page. Create a function named CK_SALE_SF that accepts a date and
-- product ID as arguments, checks whether the date falls within the product’s sale period, and returns
-- the corresponding string value. Test the function with the product ID 6 and two dates: 10-JUN-12
-- and 19-JUN-12. Verify your results by reviewing the product sales information.
CREATE OR REPLACE FUNCTION CK_SALE_SF(
  p_date DATE,
  p_product_id NUMBER
) RETURN VARCHAR2 IS
  lv_sale_start DATE;
  lv_sale_end   DATE;
  lv_sale_price NUMBER(6, 2);
BEGIN
 -- Retrieve sale start date, end date, and sale price for the given product ID
  SELECT
    SaleStart,
    SaleEnd,
    SalePrice INTO lv_sale_start,
    lv_sale_end,
    lv_sale_price
  FROM
    bb_product
  WHERE
    idProduct = p_product_id;
 -- Check if the provided date falls within the sale period
  IF p_date BETWEEN lv_sale_start AND lv_sale_end THEN
    RETURN 'ON SALE!';
  ELSE
    RETURN 'Great Deal!';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Product not found';
END CK_SALE_SF;
/

-- Test the function with the provided product ID (6) and two dates
SELECT
  CK_SALE_SF('10-JUN-2012', 6) AS Sale_Info_1,
  CK_SALE_SF('19-JUN-2012', 6) AS Sale_Info_2
FROM
  dual;

-- Assignment 6-9: Determining the Monthly Payment Amount
-- Create a function named DD_MTHPAY_SF that calculates and returns the monthly payment
-- amount for donor pledges paid on a monthly basis. Input values should be the number of
-- monthly payments and the pledge amount. Use the function in an anonymous PL/SQL block
-- to show its use with the following pledge information: pledge amount = $240 and monthly
-- payments = 12. Also, use the function in an SQL statement that displays information for all
-- donor pledges in the database on a monthly payment plan.
CREATE OR REPLACE FUNCTION DD_MTHPAY_SF(
  lv_paymonths IN NUMBER,
  lv_pledgeamt IN NUMBER
) RETURN NUMBER IS
  lv_monthly_payment NUMBER;
BEGIN
  lv_monthly_payment := lv_pledgeamt / lv_paymonths;
  RETURN lv_monthly_payment;
END DD_MTHPAY_SF;
/

-- Anonymous PL/SQL block demonstrating the use of the function
DECLARE
  lv_pledge_amount          NUMBER := 240;
  lv_monthly_payments       NUMBER := 12;
  lv_monthly_payment_amount NUMBER;
BEGIN
  lv_monthly_payment_amount := DD_MTHPAY_SF(lv_monthly_payments, lv_pledge_amount);
  DBMS_OUTPUT.PUT_LINE('Monthly payment amount for the pledge: $'
                       || lv_monthly_payment_amount);
END;
/

-- SQL statement to display information for all donor pledges in the database on a monthly payment plan
SELECT
  dp.idPledge,
  dp.idDonor,
  d.Firstname
  || ' '
  || d.Lastname                            AS Donor_Name,
  dp.Pledgeamt                             AS Pledge_Amount,
  dp.paymonths                             AS Payment_Months,
  DD_MTHPAY_SF(dp.paymonths, dp.Pledgeamt) AS Monthly_Payment_Amount
FROM
  dd_pledge dp
  JOIN dd_donor d
  ON dp.idDonor = d.idDonor
WHERE
  dp.paymonths > 0;

-- Assignment 6-10: Calculating the Total Project Pledge Amount
-- Create a function named DD_PROJTOT_SF that determines the total pledge amount for a project.
-- Use the function in an SQL statement that lists all projects, displaying project ID, project name,
-- and project pledge total amount. Format the pledge total to display zero if no pledges have been
-- made so far, and have it show a dollar sign, comma, and two decimal places for dollar values.
CREATE OR REPLACE FUNCTION DD_PROJTOT_SF(
  lv_project_id IN NUMBER
) RETURN NUMBER IS
  lv_total_pledge_amount NUMBER;
BEGIN
  SELECT
    NVL(SUM(Pledgeamt), 0) INTO lv_total_pledge_amount
  FROM
    dd_pledge
  WHERE
    idProj = lv_project_id;
  RETURN lv_total_pledge_amount;
END DD_PROJTOT_SF;
/

SELECT
  idProj,
  Projname,
  TO_CHAR(DD_PROJTOT_SF(idProj), '$999,999,999.99') AS Project_Pledge_Total
FROM
  dd_project;

-- Assignment 6-11: Identifying Pledge Status
-- The DoGood Donor organization decided to reduce SQL join activity in its application by
-- eliminating the DD_STATUS table and replacing it with a function that returns a status description
-- based on the status ID value. Create this function and name it DD_PLSTAT_SF. Use the function
-- in an SQL statement that displays the pledge ID, pledge date, and pledge status for all pledges.
-- Also, use it in an SQL statement that displays the same values but for only a specified pledge.
CREATE OR REPLACE FUNCTION DD_PLSTAT_SF(
  lv_status_id IN NUMBER
) RETURN VARCHAR2 IS
  lv_status_desc VARCHAR2(15);
BEGIN
  CASE lv_status_id
    WHEN 10 THEN
      lv_status_desc := 'Open';
    WHEN 20 THEN
      lv_status_desc := 'Complete';
    WHEN 30 THEN
      lv_status_desc := 'Overdue';
    WHEN 40 THEN
      lv_status_desc := 'Closed';
    WHEN 50 THEN
      lv_status_desc := 'Hold';
    ELSE
      lv_status_desc := 'Unknown';
  END CASE;

  RETURN lv_status_desc;
END DD_PLSTAT_SF;
/

SELECT
  idPledge,
  Pledgedate,
  DD_PLSTAT_SF(idStatus) AS Pledge_Status
FROM
  dd_pledge;

SELECT
  idPledge,
  Pledgedate,
  DD_PLSTAT_SF(idStatus) AS Pledge_Status
FROM
  dd_pledge
WHERE
  idPledge = :specified_pledge_id;

-- Assignment 6-12: Determining a Pledge’s First Payment Date
-- Create a function named DD_PAYDATE1_SF that determines the first payment due date for a
-- pledge based on pledge ID. The first payment due date is always the first day of the month
-- after the date the pledge was made, even if a pledge is made on the first of a month. Keep in
-- mind that a pledge made in December should reflect a first payment date with the following
-- year. Use the function in an anonymous block.
CREATE OR REPLACE FUNCTION DD_PAYDATE1_SF(
  lv_pledge_id IN NUMBER
) RETURN DATE IS
  lv_pledge_date        DATE;
  lv_first_payment_date DATE;
BEGIN
 -- Get the pledge date for the given pledge ID
  SELECT
    Pledgedate INTO lv_pledge_date
  FROM
    dd_pledge
  WHERE
    idPledge = lv_pledge_id;
 -- Calculate the first payment date
  IF EXTRACT(MONTH FROM lv_pledge_date) = 12 THEN
 -- If pledge made in December, first payment is in January of next year
    lv_first_payment_date := ADD_MONTHS(TRUNC(lv_pledge_date, 'YYYY'), 1);
  ELSE
 -- Otherwise, first payment is in the next month
    lv_first_payment_date := ADD_MONTHS(lv_pledge_date, 1);
  END IF;

  RETURN lv_first_payment_date;
END DD_PAYDATE1_SF;
/

DECLARE
  lv_pledge_id          NUMBER := 104; -- Replace with the desired pledge ID
  lv_first_payment_date DATE;
BEGIN
  lv_first_payment_date := DD_PAYDATE1_SF(lv_pledge_id);
  DBMS_OUTPUT.PUT_LINE('First payment due date for pledge '
                       || lv_pledge_id
                       || ': '
                       || TO_CHAR(lv_first_payment_date, 'DD-MON-YYYY'));
END;

-- Assignment 6-13: Determining a Pledge’s Final Payment Date
-- Create a function named DD_PAYEND_SF that determines the final payment date for a pledge
-- based on pledge ID. Use the function created in Assignment 6-12 in this new function to help
-- with the task. If the donation pledge indicates a lump sum payment, the final payment date is
-- the same as the first payment date. Use the function in an anonymous block.
CREATE OR REPLACE FUNCTION DD_PAYEND_SF(
  lv_pledge_id IN NUMBER
) RETURN DATE IS
  lv_final_payment_date DATE;
  lv_paymonths          NUMBER;
BEGIN
 -- Get the number of payment months for the given pledge ID
  SELECT
    paymonths INTO lv_paymonths
  FROM
    dd_pledge
  WHERE
    idPledge = lv_pledge_id;
  IF lv_paymonths IS NULL OR lv_paymonths = 0 THEN
 -- If lump sum payment, final payment date is the same as the first payment date
    lv_final_payment_date := DD_PAYDATE1_SF(lv_pledge_id);
  ELSE
 -- Calculate final payment date based on the first payment date and payment months
    lv_final_payment_date := ADD_MONTHS(DD_PAYDATE1_SF(lv_pledge_id), lv_paymonths);
  END IF;

  RETURN lv_final_payment_date;
END DD_PAYEND_SF;
/

DECLARE
  lv_pledge_id          NUMBER := 104; -- Replace with the desired pledge ID
  lv_final_payment_date DATE;
BEGIN
  lv_final_payment_date := DD_PAYEND_SF(lv_pledge_id);
  DBMS_OUTPUT.PUT_LINE('Final payment date for pledge '
                       || lv_pledge_id
                       || ': '
                       || TO_CHAR(lv_final_payment_date, 'DD-MON-YYYY'));
END;
