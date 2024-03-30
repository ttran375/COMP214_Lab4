-- Case 6-1: Updating Basket Data at Order Completion
-- A number of functions created in this chapter assume that the basket amounts, including
-- shipping, tax, and total, are already posted to the BB_BASKET table. However, the program
-- units for updating these columns when a shopper checks out haven’t been developed yet.
-- A procedure is needed to update the following columns in the BB_BASKET table when an order
-- is completed: ORDERPLACED, SUBTOTAL, SHIPPING, TAX, and TOTAL.
-- Construct three functions to perform the following tasks: calculating the subtotal by using
-- the BB_BASKETITEM table based on basket ID as input, calculating shipping costs based on
-- basket ID as input, and calculating the tax based on basket ID and subtotal as input. Use these
-- functions in a procedure.
-- A value of 1 entered in the ORDERPLACED column indicates that the shopper has
-- completed the order. The subtotal is determined by totaling the item lines of the BB_BASKETITEM
-- table for the applicable basket number. The shipping cost is based on the number of items in the
-- basket: 1 to 4 = $5, 5 to 9 = $8, and more than 10 = $11.
-- The tax is based on the rate applied by referencing the SHIPSTATE column of the
-- BB_BASKET table with the STATE column of the BB_TAX table. This rate should be multiplied
-- by the basket subtotal, which should be an INPUT parameter to the tax calculation because
-- the subtotal is being calculated in this same procedure. The total tallies all these amounts.
-- The only INPUT parameter for the procedure is a basket ID. The procedure needs to
-- update the correct row in the BB_BASKET table with all these amounts. To test, first set
-- all column values to NULL for basket 3 with the following UPDATE statement. Then call the
-- procedure for basket 3 and check the INSERT results.
-- UPDATE bb_basket
-- SET orderplaced = NULL,
-- Subtotal = NULL,
-- Tax = NULL,
-- Shipping = NULL,
-- Total = NULL
-- WHERE idBasket = 3;
-- COMMIT;
CREATE OR REPLACE FUNCTION CalculateSubtotal(
  basket_id IN NUMBER
) RETURN NUMBER IS
  total_price NUMBER(7, 2);
BEGIN
  SELECT
    SUM(bi.Price * bi.Quantity) INTO total_price
  FROM
    bb_BasketItem bi
  WHERE
    bi.idBasket = basket_id;
  RETURN total_price;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0; -- No items in the basket
END CalculateSubtotal;
/

CREATE OR REPLACE FUNCTION CalculateShipping(
  basket_id IN NUMBER
) RETURN NUMBER IS
  num_items     INTEGER;
  shipping_cost NUMBER(5, 2);
BEGIN
  SELECT
    COUNT(*) INTO num_items
  FROM
    bb_BasketItem
  WHERE
    idBasket = basket_id;
  IF num_items BETWEEN 1 AND 4 THEN
    shipping_cost := 5.00;
  ELSIF num_items BETWEEN 5 AND 9 THEN
    shipping_cost := 8.00;
  ELSE
    shipping_cost := 11.00;
  END IF;

  RETURN shipping_cost;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0; -- No items in the basket
END CalculateShipping;
/

CREATE OR REPLACE FUNCTION CalculateTax(
  basket_id IN NUMBER,
  subtotal IN NUMBER
) RETURN NUMBER IS
  state_tax_rate NUMBER(4, 3);
  tax_amount     NUMBER(5, 2);
BEGIN
  SELECT
    t.TaxRate INTO state_tax_rate
  FROM
    bb_Tax    t
    JOIN bb_Basket b
    ON t.State = b.ShipState
  WHERE
    b.idBasket = basket_id;
  tax_amount := subtotal * state_tax_rate;
  RETURN tax_amount;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0; -- Tax rate not found for the state
END CalculateTax;
/

CREATE OR REPLACE PROCEDURE UpdateBasketData(
  basket_id IN NUMBER
) IS
  subtotal NUMBER(7, 2);
  shipping NUMBER(5, 2);
  tax      NUMBER(5, 2);
  total    NUMBER(7, 2);
BEGIN
  subtotal := CalculateSubtotal(basket_id);
  shipping := CalculateShipping(basket_id);
  tax := CalculateTax(basket_id, subtotal);
  total := subtotal + shipping + tax;
  UPDATE bb_Basket
  SET
    ORDERPLACED = 1,
    SUBTOTAL = subtotal,
    SHIPPING = shipping,
    TAX = tax,
    TOTAL = total
  WHERE
    idBasket = basket_id;
  COMMIT;
END UpdateBasketData;
/

BEGIN
  UpdateBasketData(3);
END;
/

-- Case 6-2: Working with More Movies Rentals
-- More Movies receives numerous requests to check whether movies are in stock. The company
-- needs a function that retrieves movie stock information and formats a clear message to display
-- to users requesting information. The display should resemble the following: “Star Wars is
-- Available: 11 on the shelf.”
-- Use movie ID as the input value for this function. Assume the MOVIE_QTY column in the
-- MM_MOVIES table indicates the number of movies currently available for checkout.
CREATE OR REPLACE FUNCTION get_movie_stock(
  movie_id_in NUMBER
) RETURN VARCHAR2 IS
  lv_movie_title mm_movie.movie_title%TYPE;
  lv_movie_qty   mm_movie.movie_qty%TYPE;
  lv_message     VARCHAR2(100);
BEGIN
 -- Retrieve movie title and quantity based on movie ID
  SELECT
    movie_title,
    movie_qty INTO lv_movie_title,
    lv_movie_qty
  FROM
    mm_movie
  WHERE
    movie_id = movie_id_in;
 -- Construct message
  lv_message := lv_movie_title
               || ' is ';
  IF lv_movie_qty > 0 THEN
    lv_message := lv_message
                 || 'Available: '
                 || lv_movie_qty
                 || ' on the shelf.';
  ELSE
    lv_message := lv_message
                 || 'Not available for rental at the moment.';
  END IF;
 -- Return the formatted message
  RETURN lv_message;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Movie with ID '
           || movie_id_in
           || ' not found.';
END;
/

-- Example usage:
DECLARE
  lv_result VARCHAR2(100);
BEGIN
  lv_result := get_movie_stock(3); -- Check stock for "Star Wars"
  DBMS_OUTPUT.PUT_LINE(lv_result);
END;
