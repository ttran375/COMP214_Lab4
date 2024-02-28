-- Assignment 5-1: Creating a Procedure
-- Use these steps to create a procedure that allows a company employee to make corrections to
-- a product’s assigned name. Review the BB_PRODUCT table and identify the PRODUCT NAME
-- and PRIMARY KEY columns. The procedure needs two IN parameters to identify the product
-- ID and supply the new description. This procedure needs to perform only a DML action, so no
-- OUT parameters are necessary.
-- 1. In SQL Developer, create the following procedure:
-- CREATE OR REPLACE PROCEDURE prod_name_sp
-- (p_prodid IN bb_product.idproduct%TYPE,
-- p_descrip IN bb_product.description%TYPE)
-- IS
-- BEGIN
-- UPDATE bb_product
-- SET description = p_descrip
-- WHERE idproduct = p_prodid;
-- COMMIT;
-- END;
-- 2. Before testing the procedure, verify the current description value for product ID 1 with
-- SELECT * FROM bb_product;.
-- 3. Call the procedure with parameter values of 1 for the product ID and CapressoBar Model
-- #388 for the description.
-- 4. Verify that the update was successful by querying the table with SELECT * FROM
-- bb_product;.

-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE prod_name_sp (
  p_prodid IN bb_product.idProduct%TYPE,
  p_descrip IN bb_product.Description%TYPE
) IS
BEGIN
  UPDATE bb_product
  SET
    Description = p_descrip
  WHERE
    idProduct = p_prodid;
  COMMIT;
END;
/

-- Step 2: Verify the current description value
SELECT
  *
FROM
  bb_product
WHERE
  idProduct = 1;

-- Step 3: Call the procedure
BEGIN
  prod_name_sp(1, 'CapressoBar Model #388');
END;
/

-- Step 4: Verify that the update was successful
SELECT
  *
FROM
  bb_product
WHERE
  idProduct = 1;

-- Assignment 5-2: Using a Procedure with IN Parameters
-- Follow these steps to create a procedure that allows a company employee to add a new
-- product to the database. This procedure needs only IN parameters.
-- 1. In SQL Developer, create a procedure named PROD_ADD_SP that adds a row for a new
-- product in the BB_PRODUCT table. Keep in mind that the user provides values for the
-- product name, description, image filename, price, and active status. Address the input
-- values or parameters in the same order as in the preceding sentence.
-- 2. Call the procedure with these parameter values: ('Roasted Blend', 'Well-balanced
-- mix of roasted beans, a medium body', 'roasted.jpg',9.50,1).
-- 3. Check whether the update was successful by querying the BB_PRODUCT table.

-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE PROD_ADD_SP (
  p_product_name IN VARCHAR2,
  p_description IN VARCHAR2,
  p_image_filename IN VARCHAR2,
  p_price IN NUMBER,
  p_active_status IN NUMBER
) AS
BEGIN
  INSERT INTO BB_PRODUCT (
    product_name,
    description,
    image_filename,
    price,
    active_status
  ) VALUES (
    p_product_name,
    p_description,
    p_image_filename,
    p_price,
    p_active_status
  );
  COMMIT;
END;
/

-- Step 2: Call the procedure with the specified parameter values
BEGIN
  PROD_ADD_SP('Roasted Blend', 'Well-balanced mix of roasted beans, a medium body', 'roasted.jpg', 9.50, 1);
END;
/

-- Step 3: Check whether the update was successful by querying the BB_PRODUCT table
SELECT
  *
FROM
  BB_PRODUCT;

-- Assignment 5-3: Calculating the Tax on an Order
-- Follow these steps to create a procedure for calculating the tax on an order. The BB_TAX table
-- contains states that require submitting taxes for Internet sales. If the state isn’t listed in the
-- table, no tax should be assessed on the order. The shopper’s state and basket subtotal are the
-- inputs to the procedure, and the tax amount should be returned.
-- 1. In SQL Developer, create a procedure named TAX_COST_SP. Remember that the state
-- and subtotal values are inputs to the procedure, which should return the tax amount.
-- Review the BB_TAX table, which contains the tax rate for each applicable state.
-- 2. Call the procedure with the values VA for the state and $100 for the subtotal. Display the
-- tax amount the procedure returns. (It should be $4.50.)

-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE TAX_COST_SP (
  p_state IN VARCHAR2,
  p_subtotal IN NUMBER,
  p_tax OUT NUMBER
) AS
BEGIN
  SELECT
    TaxRate INTO p_tax
  FROM
    bb_tax
  WHERE
    State = p_state;
  IF p_tax IS NULL THEN
    p_tax := 0;
  ELSE
    p_tax := p_subtotal * p_tax;
  END IF;
END TAX_COST_SP;
/

-- Step 2: Call the procedure with the specified parameter values
DECLARE
  lv_state    VARCHAR2(2) := 'VA';
  lv_subtotal NUMBER := 100;
  lv_tax      NUMBER;
BEGIN
  TAX_COST_SP(lv_state, lv_subtotal, lv_tax);
  DBMS_OUTPUT.PUT_LINE('Tax Amount: $'
                       || TO_CHAR(lv_tax, '999.99'));
END;
/

-- Assignment 5-4: Updating Columns in a Table
-- After a shopper completes an order, a procedure is called to update the following columns in the
-- BASKET table: ORDERPLACED, SUBTOTAL, SHIPPING, TAX, and TOTAL. The value 1
-- entered in the ORDERPLACED column indicates that the shopper has completed an order.
-- Inputs to the procedure are the basket ID and amounts for the subtotal, shipping, tax, and total.
-- 1. In SQL Developer, create a procedure named BASKET_CONFIRM_SP that accepts the input
-- values specified in the preceding description. Keep in mind that you’re modifying an existing
-- row of the BB_BASKET table in this procedure.
-- 2. Enter the following statements to create a new basket containing two items:
-- INSERT INTO BB_BASKET (IDBASKET, QUANTITY, IDSHOPPER,
-- ORDERPLACED, SUBTOTAL, TOTAL,
-- SHIPPING, TAX, DTCREATED, PROMO)
-- VALUES (17, 2, 22, 0, 0, 0, 0, 0, '28-FEB-12', 0);
-- INSERT INTO BB_BASKETITEM (IDBASKETITEM, IDPRODUCT, PRICE,
-- QUANTITY, IDBASKET, OPTION1, OPTION2)
-- VALUES (44, 7, 10.8, 3, 17, 2, 3);
-- INSERT INTO BB_BASKETITEM (IDBASKETITEM, IDPRODUCT, PRICE,
-- QUANTITY, IDBASKET, OPTION1, OPTION2)
-- VALUES (45, 8, 10.8, 3, 17, 2, 3);
-- 3. Type and run COMMIT; to save the data from these statements.
-- 4. Call the procedure with the following parameter values: 17, 64.80, 8.00, 1.94, 74.74.
-- As mentioned, these values represent the basket ID and the amounts for the subtotal,
-- shipping, tax, and total.
-- 5. Query the BB_BASKET table to confirm that the procedure was successful:
-- SELECT subtotal, shipping, tax, total, orderplaced
-- FROM bb_basket
-- WHERE idbasket = 17;.

-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE BASKET_CONFIRM_SP (
  p_idbasket IN BB_BASKET.IDBASKET%TYPE,
  p_subtotal IN BB_BASKET.SUBTOTAL%TYPE,
  p_shipping IN BB_BASKET.SHIPPING%TYPE,
  p_tax IN BB_BASKET.TAX%TYPE,
  p_total IN BB_BASKET.TOTAL%TYPE
) IS
BEGIN
  UPDATE BB_BASKET
  SET
    ORDERPLACED = 1,
    SUBTOTAL = p_subtotal,
    SHIPPING = p_shipping,
    TAX = p_tax,
    TOTAL = p_total
  WHERE
    IDBASKET = p_idbasket;
  COMMIT;
END;
/

-- Step 2: Execute the provided INSERT statements to create a new basket and basket items
INSERT INTO BB_BASKET (
  IDBASKET,
  QUANTITY,
  IDSHOPPER,
  ORDERPLACED,
  SUBTOTAL,
  TOTAL,
  SHIPPING,
  TAX,
  DTCREATED,
  PROMO
) VALUES (
  17,
  2,
  22,
  0,
  0,
  0,
  0,
  0,
  TO_DATE('28-FEB-12', 'DD-MON-YY'),
  0
);

INSERT INTO BB_BASKETITEM (
  IDBASKETITEM,
  IDPRODUCT,
  PRICE,
  QUANTITY,
  IDBASKET,
  OPTION1,
  OPTION2
) VALUES (
  44,
  7,
  10.8,
  3,
  17,
  2,
  3
);

INSERT INTO BB_BASKETITEM (
  IDBASKETITEM,
  IDPRODUCT,
  PRICE,
  QUANTITY,
  IDBASKET,
  OPTION1,
  OPTION2
) VALUES (
  45,
  8,
  10.8,
  3,
  17,
  2,
  3
);

COMMIT;

-- Step 3: Commit the transaction to save the data
COMMIT;

-- Step 4: Call the procedure with the provided parameter values
BEGIN
  BASKET_CONFIRM_SP(17, 64.80, 8.00, 1.94, 74.74);
END;
/

-- Step 5: Query the BB_BASKET table to confirm the changes
SELECT
  subtotal,
  shipping,
  tax,
  total,
  orderplaced
FROM
  bb_basket
WHERE
  idbasket = 17;

-- Assignment 5-5: Updating Order Status
-- Create a procedure named STATUS_SHIP_SP that allows an employee in the Shipping
-- Department to update an order status to add shipping information. The BB_BASKETSTATUS
-- table lists events for each order so that a shopper can see the current status, date, and
-- comments as each stage of the order process is finished. The IDSTAGE column of the
-- BB_BASKETSTATUS table identifies each stage; the value 3 in this column indicates that an
-- order has been shipped.
-- The procedure should allow adding a row with an IDSTAGE of 3, date shipped, tracking
-- number, and shipper. The BB_STATUS_SEQ sequence is used to provide a value for the primary
-- key column. Test the procedure with the following information:
-- Basket # = 3
-- Date shipped = 20-FEB-12
-- Shipper = UPS
-- Tracking # = ZW2384YXK4957
-- Step 1: Create the procedure
-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE STATUS_SHIP_SP (
  p_basket_id IN NUMBER,
  p_date_shipped IN DATE,
  p_shipper IN VARCHAR2,
  p_tracking_number IN VARCHAR2
) AS
BEGIN
  INSERT INTO BB_BASKETSTATUS (
    IDBASKETSTATUS,
    IDBASKET,
    IDSTAGE,
    DTEVENT,
    COMMENTS
  ) VALUES (
    BB_STATUS_SEQ.NEXTVAL,
    p_basket_id,
    3,
    p_date_shipped,
    'Shipped via '
    || p_shipper
    || ', Tracking Number: '
    || p_tracking_number
  );
  COMMIT;
END;
/

-- Step 2: Test the procedure with the provided information
BEGIN
  STATUS_SHIP_SP(3, TO_DATE('20-FEB-12', 'DD-MON-YY'), 'UPS', 'ZW2384YXK4957');
END;
/

-- Assignment 5-6: Returning Order Status Information
-- Create a procedure that returns the most recent order status information for a specified basket.
-- This procedure should determine the most recent ordering-stage entry in the BB_BASKETSTATUS
-- table and return the data. Use an IF or CASE clause to return a stage description instead
-- of an IDSTAGE number, which means little to shoppers. The IDSTAGE column of the
-- BB_BASKETSTATUS table identifies each stage as follows:
-- • 1—Submitted and received
-- • 2—Confirmed, processed, sent to shipping
-- • 3—Shipped
-- • 4—Cancelled
-- • 5—Back-ordered
-- The procedure should accept a basket ID number and return the most recent status
-- description and date the status was recorded. If no status is available for the specified basket
-- ID, return a message stating that no status is available. Name the procedure STATUS_SP. Test
-- the procedure twice with the basket ID 4 and then 6.
-- Step 1: Create the procedure
CREATE OR REPLACE PROCEDURE STATUS_SP (
    p_basket_id    IN NUMBER,
    p_status_desc  OUT VARCHAR2,
    p_status_date  OUT DATE
)
AS
BEGIN
    SELECT 
        CASE 
            WHEN bs.IDSTAGE = 1 THEN 'Submitted and received'
            WHEN bs.IDSTAGE = 2 THEN 'Confirmed, processed, sent to shipping'
            WHEN bs.IDSTAGE = 3 THEN 'Shipped'
            WHEN bs.IDSTAGE = 4 THEN 'Cancelled'
            WHEN bs.IDSTAGE = 5 THEN 'Back-ordered'
            ELSE 'Unknown'
        END,
        bs.DTEVENT
    INTO 
        p_status_desc,
        p_status_date
    FROM 
        BB_BASKETSTATUS bs
    WHERE 
        bs.IDBASKET = p_basket_id
    ORDER BY 
        bs.DTEVENT DESC;
    
    IF SQL%NOTFOUND THEN
        p_status_desc := 'No status available';
        p_status_date := NULL;
    END IF;
END;
/

-- Step 2: Test the procedure with basket ID 4
DECLARE
    v_status_desc VARCHAR2(100);
    v_status_date DATE;
BEGIN
    STATUS_SP(4, v_status_desc, v_status_date);
    DBMS_OUTPUT.PUT_LINE('Status for Basket ID 4: ' || v_status_desc || ', recorded on ' || TO_CHAR(v_status_date, 'DD-MON-YYYY'));
END;
/

-- Test the procedure with basket ID 6
DECLARE
    v_status_desc VARCHAR2(100);
    v_status_date DATE;
BEGIN
    STATUS_SP(6, v_status_desc, v_status_date);
    DBMS_OUTPUT.PUT_LINE('Status for Basket ID 6: ' || v_status_desc || ', recorded on ' || TO_CHAR(v_status_date, 'DD-MON-YYYY'));
END;
/

-- Assignment 5-7: Identifying Customers
-- Brewbean’s wants to offer an incentive of free shipping to customers who haven’t returned to
-- the site since a specified date. Create a procedure named PROMO_SHIP_SP that determines
-- who these customers are and then updates the BB_PROMOLIST table accordingly. The
-- procedure uses the following information:
-- • Date cutoff—Any customers who haven’t shopped on the site since this date
-- should be included as incentive participants. Use the basket creation date to
-- reflect shopper activity dates.
-- • Month—A three-character month (such as APR) should be added to the promotion
-- table to indicate which month free shipping is effective.
-- • Year—A four-digit year indicates the year the promotion is effective.
-- • promo_flag—1 represents free shipping.
-- The BB_PROMOLIST table also has a USED column, which contains the default value N
-- and is updated to Y when the shopper uses the promotion. Test the procedure with the cutoff
-- date 15-FEB-12. Assign free shipping for the month APR and the year 2012.
CREATE OR REPLACE PROCEDURE PROMO_SHIP_SP (
  p_cutoff_date IN DATE,
  p_month IN VARCHAR2,
  p_year IN NUMBER
) AS
BEGIN
 -- Identify customers who haven't shopped since the cutoff date
  FOR customer IN (
    SELECT
      DISTINCT bs.IDSHOPPER
    FROM
      BB_BASKET bs
    WHERE
      bs.DTCREATED < p_cutoff_date
      AND NOT EXISTS (
        SELECT
          1
        FROM
          BB_BASKET bs2
        WHERE
          bs2.IDSHOPPER = bs.IDSHOPPER
          AND bs2.DTCREATED > p_cutoff_date
      )
  ) LOOP
 -- Update BB_PROMOLIST for each eligible customer
    INSERT INTO BB_PROMOLIST (
      IDSHOPPER,
      MONTH,
      YEAR,
      PROMO_FLAG,
      USED
    ) VALUES (
      customer.IDSHOPPER,
      p_month,
      p_year,
      1,
      'N'
    );
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Promotion records updated successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: '
                         || SQLERRM);
END;
/

BEGIN
  PROMO_SHIP_SP(TO_DATE('15-FEB-12', 'DD-MON-YYYY'), 'APR', 2012);
END;
/

-- Assignment 5-8: Adding Items to a Basket
-- As a shopper selects products on the Brewbean’s site, a procedure is needed to add a newly
-- selected item to the current shopper’s basket. Create a procedure named BASKET_ADD_SP that
-- accepts a product ID, basket ID, price, quantity, size code option (1 or 2), and form code option
-- (3 or 4) and uses this information to add a new item to the BB_BASKETITEM table. The table’s
-- PRIMARY KEY column is generated by BB_IDBASKETITEM_SEQ. Run the procedure with the
-- following values:
-- • Basket ID—14
-- • Product ID—8
-- • Price—10.80
-- • Quantity—1
-- • Size code—2
-- • Form code—4
CREATE OR REPLACE PROCEDURE BASKET_ADD_SP (
  p_basket_id IN NUMBER,
  p_product_id IN NUMBER,
  p_price IN NUMBER,
  p_quantity IN NUMBER,
  p_size_code IN NUMBER,
  p_form_code IN NUMBER
) AS
BEGIN
  INSERT INTO BB_BASKETITEM (
    IDBASKETITEM,
    IDPRODUCT,
    PRICE,
    QUANTITY,
    IDBASKET,
    OPTION1,
    OPTION2
  ) VALUES (
    BB_IDBASKETITEM_SEQ.NEXTVAL,
    p_product_id,
    p_price,
    p_quantity,
    p_basket_id,
    p_size_code,
    p_form_code
  );
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Item added to basket successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: '
                         || SQLERRM);
END;
/

BEGIN
  BASKET_ADD_SP(14, 8, 10.80, 1, 2, 4);
END;
/

-- Assignment 5-9: Creating a Logon Procedure
-- The home page of the Brewbean’s Web site has an option for members to log on with their IDs
-- and passwords. Develop a procedure named MEMBER_CK_SP that accepts the ID and password
-- as inputs, checks whether they make up a valid logon, and returns the member name and cookie
-- value. The name should be returned as a single text string containing the first and last name.
-- The head developer wants the number of parameters minimized so that the same
-- parameter is used to accept the password and return the name value. Also, if the user doesn’t
-- enter a valid username and password, return the value INVALID in a parameter named
-- p_check. Test the procedure using a valid logon first, with the username rat55 and password
-- kile. Then try it with an invalid logon by changing the username to rat.
CREATE OR REPLACE PROCEDURE MEMBER_CK_SP (
  p_username IN VARCHAR2,
  p_password IN OUT VARCHAR2,
  p_name OUT VARCHAR2,
  p_check OUT VARCHAR2
) AS
  v_member_name VARCHAR2(100);
BEGIN
 -- Check if the username and password are valid
  SELECT
    first_name
    || ' '
    || last_name INTO v_member_name
  FROM
    BB_MEMBER
  WHERE
    username = p_username
    AND password = p_password;
 -- If a record is found, the username and password are valid
  IF v_member_name IS NOT NULL THEN
    p_name := v_member_name;
    p_check := 'VALID';
 -- Generate and return the cookie value (for simplicity, a placeholder is used here)
    p_password := 'cookie_value_placeholder';
  ELSE
 -- If no record is found, the username and password are invalid
    p_check := 'INVALID';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
 -- If no record is found, the username and password are invalid
    p_check := 'INVALID';
  WHEN OTHERS THEN
 -- Handle other exceptions
    p_check := 'ERROR: '
               || SQLERRM;
END;
/

DECLARE
  v_password VARCHAR2(100) := 'kile'; -- Valid password
  v_name     VARCHAR2(100);
  v_check    VARCHAR2(100);
BEGIN
  MEMBER_CK_SP('rat55', v_password, v_name, v_check);
  DBMS_OUTPUT.PUT_LINE('Name: '
                       || v_name);
  DBMS_OUTPUT.PUT_LINE('Check: '
                       || v_check);
  DBMS_OUTPUT.PUT_LINE('Cookie Value: '
                       || v_password); -- Placeholder for cookie value
END;
/

DECLARE
  v_password VARCHAR2(100) := 'invalid_password'; -- Invalid password
  v_name     VARCHAR2(100);
  v_check    VARCHAR2(100);
BEGIN
  MEMBER_CK_SP('rat', v_password, v_name, v_check); -- Invalid username
  DBMS_OUTPUT.PUT_LINE('Name: '
                       || v_name);
  DBMS_OUTPUT.PUT_LINE('Check: '
                       || v_check);
  DBMS_OUTPUT.PUT_LINE('Cookie Value: '
                       || v_password); -- Placeholder for cookie value
END;
/

