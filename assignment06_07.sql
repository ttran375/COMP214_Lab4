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
