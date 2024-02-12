-- Assignment 3-1: Querying Data in a Block
-- A Brewbean’s application page is being developed for employees to enter a basket number and
-- view shipping information for the order that includes date, shipper, and shipping number. An
-- IDSTAGE value of 5 in the BB_BASKETSTATUS table indicates that the order has been
-- shipped. In this assignment, you create a block using scalar variables to hold the data retrieved
-- from the database. Follow these steps to create a block for checking shipping information:
-- 1. Start SQL Developer, if necessary.
-- 2. Open the assignment03-01.sql file in the Chapter03 folder.
-- 3. Review the code, and note the use of scalar variables to hold the values retrieved in the
-- SELECT statement.
-- 4. Add data type assignments to the first three variables declared. These variables will be
-- used to hold data retrieved from a query.
-- 5. Run the block for basket ID 3, and compare the results with Figure 3-29.
-- 6. Now try to run this same block with a basket ID that has no shipping information recorded.
-- Edit the basket ID variable to be 7.
-- 7. Run the block again, and review the error shown in Figure 3-30.
DECLARE
    lv_ship_date   bb_basketstatus.dtstage%TYPE := SYSDATE;
    lv_shipper_txt bb_basketstatus.shipper%TYPE := 'Default Shipper';
    lv_ship_num    bb_basketstatus.shippingnum%TYPE := 1;
    lv_bask_num    bb_basketstatus.idbasket%TYPE := 3;
 -- lv_bask_num    bb_basketstatus.idbasket%TYPE := 7;
BEGIN
    SELECT
        dtstage,
        shipper,
        shippingnum INTO lv_ship_date,
        lv_shipper_txt,
        lv_ship_num
    FROM
        bb_basketstatus
    WHERE
        idbasket = lv_bask_num
        AND idstage = 5;
    DBMS_OUTPUT.PUT_LINE('Date Shipped: '
                         ||lv_ship_date);
    DBMS_OUTPUT.PUT_LINE('Shipper: '
                         ||lv_shipper_txt);
    DBMS_OUTPUT.PUT_LINE('Shipping #: '
                         ||lv_ship_num);
END;
 -- Assignment 3-2: Using a Record Variable
 -- A Brewbean’s application page is being developed for employees to enter a basket number
 -- and view shipping information for the order. The page needs to display all column values from
 -- the BB_BASKETSTATUS table. An IDSTAGE value of 5 in the BB_BASKETSTATUS table
 -- indicates that the order has been shipped. Follow these steps to create a block with a
 -- record variable:
 -- 1. Start SQL Developer, if necessary.
 -- 2. Open the assignment03-02.sql file in the Chapter03 folder.
 -- 3. Review the code, and note the use of a record variable to hold the values retrieved in the
 -- SELECT statement. Also, notice that the record variable’s values are referenced separately
 -- in the DBMS_OUTPUT statements.
 -- 4. Run the block, and compare the results with Figure 3-31.
DECLARE
    rec_ship    bb_basketstatus%ROWTYPE;
    lv_bask_num bb_basketstatus.idbasket%TYPE := 3;
BEGIN
    SELECT
        * INTO rec_ship
    FROM
        bb_basketstatus
    WHERE
        idbasket = lv_bask_num
        AND idstage = 5;
    DBMS_OUTPUT.PUT_LINE('Date Shipped: '
                         ||rec_ship.dtstage);
    DBMS_OUTPUT.PUT_LINE('Shipper: '
                         ||rec_ship.shipper);
    DBMS_OUTPUT.PUT_LINE('Shipping #: '
                         ||rec_ship.shippingnum);
    DBMS_OUTPUT.PUT_LINE('Notes: '
                         ||rec_ship.notes);
END;

 -- Assignment 3-3: Processing Database Data with IF Statements
 -- The Brewbean’s application needs a block to determine whether a customer is rated HIGH,
 -- MID, or LOW based on his or her total purchases. The block needs to select the total amount of
 -- orders for a specified customer, determine the rating, and then display the results onscreen. The
 -- code rates the customer HIGH if total purchases are greater than $200, MID if greater than
 -- $100, and LOW if $100 or lower. Use an initialized variable to provide the shopper ID.
 -- 1. Start SQL Developer, if necessary.
 -- 2. Open the assignment03-03.sql file from the Chapter03 folder. Review the partial block.
 -- Edit the block to perform the required task.
 -- 3. Run the block and verify the results. Enter and run the following SQL query to confirm that
 -- the total for this shopper is indeed greater than $200:
 -- SELECT SUM(total)
 -- FROM bb_basket
 -- WHERE idShopper = 22
 -- AND orderplaced = 1
 -- GROUP BY idshopper;
 -- 4. Test other shoppers who have a completed order.
DECLARE
    lv_total_num  NUMBER(6, 2);
    lv_rating_txt VARCHAR2(4);
    lv_shop_num   bb_basket.idshopper%TYPE := 22;
BEGIN
    SELECT
        SUM(total) INTO lv_total_num
    FROM
        bb_basket
    WHERE
        idShopper = lv_shop_num
        AND orderplaced = 1
    GROUP BY
        idshopper;
    IF lv_total_num > 200 THEN
        lv_rating_txt := 'HIGH';
    ELSIF lv_total_num > 100 THEN
        lv_rating_txt := 'MID';
    ELSE
        lv_rating_txt := 'LOW';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Shopper '
                         ||lv_shop_num
                         ||' is rated '
                         ||lv_rating_txt);
END;

SELECT
    SUM(total)
FROM
    bb_basket
WHERE
    idShopper = 22
    AND orderplaced = 1
GROUP BY
    idshopper;

-- Assignment 3-4: Using Searched CASE Statements
-- The Brewbean’s application needs a block to determine whether a customer is rated HIGH,
-- MID, or LOW based on his or her total purchases. The block needs to select the total amount of
-- orders for a specified customer, determine the rating, and then display the results onscreen.
-- The code rates the customer HIGH if total purchases are greater than $200, MID if greater than
-- $100, and LOW if $100 or lower. Use an initialized variable to provide the shopper ID.
-- 1. Start SQL Developer, if necessary.
-- 2. Modify the code used in Assignment 3-3 to use a searched CASE statement to check the
-- shopper’s total purchase amount and determine the correct rating.
-- 3. Run the block, and verify the results.
-- 4. Enter and run the following code to confirm that the total for this shopper is indeed greater
-- than $200:
-- SELECT SUM(total)
-- FROM bb_basket
-- WHERE idShopper = 22
-- AND orderplaced = 1
-- GROUP BY idshopper;
-- 5. Test other shoppers who have a completed order.
DECLARE
  lv_total_num NUMBER(6,2);
  lv_rating_txt VARCHAR2(4);
  lv_shop_num bb_basket.idshopper%TYPE := 22;
BEGIN
  SELECT SUM(total) INTO lv_total_num
  FROM bb_basket
  WHERE idShopper = lv_shop_num
    AND orderplaced = 1
  GROUP BY idshopper;

  lv_rating_txt := 
    CASE 
      WHEN lv_total_num > 200 THEN 'HIGH'
      WHEN lv_total_num > 100 THEN 'MID'
      ELSE 'LOW'
    END;

  DBMS_OUTPUT.PUT_LINE('Shopper '||lv_shop_num||' is rated '||lv_rating_txt);
END;

-- Assignment 3-5: Using a WHILE Loop
-- Brewbean’s wants to include a feature in its application that calculates the total amount (quantity)
-- of a specified item that can be purchased with a given amount of money. Create a block with a
-- WHILE loop to increment the item’s cost until the dollar value is met. Test first with a total spending
-- amount of $100 and product ID 4. Then test with an amount and a product of your choice. Use
-- initialized variables to provide the total spending amount and product ID.
DECLARE
  lv_total_spend NUMBER(6,2) := 100; -- total spending amount
  lv_prod_id bb_product.idproduct%TYPE := 4; -- product ID
  lv_prod_price NUMBER(6,2);
  lv_quantity NUMBER(6,2) := 0;
BEGIN
  SELECT price INTO lv_prod_price
  FROM bb_product
  WHERE idproduct = lv_prod_id;

  WHILE lv_total_spend >= lv_prod_price LOOP
    lv_total_spend := lv_total_spend - lv_prod_price;
    lv_quantity := lv_quantity + 1;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('With $100, you can buy '||lv_quantity||' units of product ID '||lv_prod_id);
END;

-- Assignment 3-6: Working with IF Statements
-- Brewbean’s calculates shipping cost based on the quantity of items in an order. Assume the
-- quantity column in the BB_BASKET table contains the total number of items in a basket.
-- A block is needed to check the quantity provided by an initialized variable and determine the
-- shipping cost. Display the calculated shipping cost onscreen. Test using the basket IDs 5 and
-- 12, and apply the shipping rates listed in Table 3-3.
-- TABLE 3-3 Shipping Charges
-- Quantity of Items Shipping Cost
-- Up to 3 $5.00
-- 4–6 $7.50
-- 7–10 $10.00
-- More than 10 $12.00
DECLARE
  lv_bask_id bb_basket.idbasket%TYPE := 5; -- change to 12 for the second test
  lv_quantity NUMBER(6,2);
  lv_shipping_cost NUMBER(6,2);
BEGIN
  SELECT quantity INTO lv_quantity
  FROM bb_basket
  WHERE idbasket = lv_bask_id;

  IF lv_quantity <= 3 THEN
    lv_shipping_cost := 5;
  ELSIF lv_quantity <= 6 THEN
    lv_shipping_cost := 7.5;
  ELSIF lv_quantity <= 10 THEN
    lv_shipping_cost := 10;
  ELSE
    lv_shipping_cost := 12;
  END IF;

  DBMS_OUTPUT.PUT_LINE('Shipping cost for basket ID '||lv_bask_id||' is $'||lv_shipping_cost);
END;

-- Assignment 3-7: Using Scalar Variables for Data Retrieval
-- The Brewbean’s application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET
-- table. Create a PL/SQL block with scalar variables to retrieve this data and then display it
-- onscreen. An initialized variable should provide the IDBASKET value. Test the block using the
-- basket ID 12.
DECLARE
    lv_idbasket bb_basket.idbasket%TYPE := 12;
    lv_subtotal bb_basket.subtotal%TYPE;
    lv_shipping bb_basket.shipping%TYPE;
    lv_tax bb_basket.tax%TYPE;
    lv_total bb_basket.total%TYPE;
BEGIN
    SELECT
        subtotal,
        shipping,
        tax,
        total INTO lv_subtotal,
        lv_shipping,
        lv_tax,
        lv_total
    FROM
        bb_basket
    WHERE
        idbasket = lv_idbasket;

    DBMS_OUTPUT.PUT_LINE('IDBASKET: ' || lv_idbasket);
    DBMS_OUTPUT.PUT_LINE('SUBTOTAL: ' || lv_subtotal);
    DBMS_OUTPUT.PUT_LINE('SHIPPING: ' || lv_shipping);
    DBMS_OUTPUT.PUT_LINE('TAX: ' || lv_tax);
    DBMS_OUTPUT.PUT_LINE('TOTAL: ' || lv_total);
END;

-- Assignment 3-8: Using a Record Variable for Data Retrieval
-- The Brewbean’s application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET
-- table. Create a PL/SQL block with a record variable to retrieve this data and display it
-- onscreen. An initialized variable should provide the IDBASKET value. Test the block using
-- the basket ID 12.
DECLARE
    TYPE basket_rec_type IS RECORD (
        idbasket bb_basket.idbasket%TYPE,
        subtotal bb_basket.subtotal%TYPE,
        shipping bb_basket.shipping%TYPE,
        tax bb_basket.tax%TYPE,
        total bb_basket.total%TYPE
    );
    basket_rec basket_rec_type;
    lv_idbasket bb_basket.idbasket%TYPE := 12;
BEGIN
    SELECT
        idbasket,
        subtotal,
        shipping,
        tax,
        total INTO basket_rec
    FROM
        bb_basket
    WHERE
        idbasket = lv_idbasket;

    DBMS_OUTPUT.PUT_LINE('IDBASKET: ' || basket_rec.idbasket);
    DBMS_OUTPUT.PUT_LINE('SUBTOTAL: ' || basket_rec.subtotal);
    DBMS_OUTPUT.PUT_LINE('SHIPPING: ' || basket_rec.shipping);
    DBMS_OUTPUT.PUT_LINE('TAX: ' || basket_rec.tax);
    DBMS_OUTPUT.PUT_LINE('TOTAL: ' || basket_rec.total);
END;

-- Assignment 3-9: Retrieving Pledge Totals
-- Create a PL/SQL block that retrieves and displays information for a specific project based on
-- Project ID. Display the following on a single row of output: project ID, project name, number of
-- pledges made, total dollars pledged, and the average pledge amount.
DECLARE
    lv_project_id projects.project_id%TYPE := 1; -- replace with your project id
    lv_project_name projects.project_name%TYPE;
    lv_pledge_count NUMBER;
    lv_total_pledged NUMBER;
    lv_avg_pledge NUMBER;
BEGIN
    SELECT p.project_name, COUNT(pl.pledge_id), SUM(pl.pledge_amount), AVG(pl.pledge_amount)
    INTO lv_project_name, lv_pledge_count, lv_total_pledged, lv_avg_pledge
    FROM projects p
    JOIN pledges pl ON p.project_id = pl.project_id
    WHERE p.project_id = lv_project_id
    GROUP BY p.project_name;

    DBMS_OUTPUT.PUT_LINE('Project ID: ' || lv_project_id);
    DBMS_OUTPUT.PUT_LINE('Project Name: ' || lv_project_name);
    DBMS_OUTPUT.PUT_LINE('Number of Pledges: ' || lv_pledge_count);
    DBMS_OUTPUT.PUT_LINE('Total Dollars Pledged: ' || lv_total_pledged);
    DBMS_OUTPUT.PUT_LINE('Average Pledge Amount: ' || lv_avg_pledge);
END;

-- Assignment 3-10: Adding a Project
-- Create a PL/SQL block to handle adding a new project. Create and use a sequence named
-- DD_PROJID_SEQ to handle generating and populating the project ID. The first number issued
-- by this sequence should be 530, and no caching should be used. Use a record variable to
-- handle the data to be added. Data for the new row should be the following: project name = HK
-- Animal Shelter Extension, start = 1/1/2013, end = 5/31/2013, and fundraising goal = $65,000.
-- Any columns not addressed in the data list are currently unknown.
CREATE SEQUENCE DD_PROJID_SEQ
  START WITH 530
  INCREMENT BY 1
  NOCACHE;

DECLARE
  TYPE project_rec_type IS RECORD (
    project_id NUMBER,
    project_name VARCHAR2(100),
    start_date DATE,
    end_date DATE,
    fundraising_goal NUMBER
  );
  project_rec project_rec_type;
BEGIN
  project_rec.project_id := DD_PROJID_SEQ.NEXTVAL;
  project_rec.project_name := 'HK Animal Shelter Extension';
  project_rec.start_date := TO_DATE('1/1/2013', 'MM/DD/YYYY');
  project_rec.end_date := TO_DATE('5/31/2013', 'MM/DD/YYYY');
  project_rec.fundraising_goal := 65000;

  INSERT INTO projects (project_id, project_name, start_date, end_date, fundraising_goal)
  VALUES (project_rec.project_id, project_rec.project_name, project_rec.start_date, project_rec.end_date, project_rec.fundraising_goal);

  COMMIT;
END;

-- Assignment 3-11: Retrieving and Displaying Pledge Data
-- Create a PL/SQL block to retrieve and display data for all pledges made in a specified month.
-- One row of output should be displayed for each pledge. Include the following in each row
-- of output:
-- • Pledge ID, donor ID, and pledge amount
-- • If the pledge is being paid in a lump sum, display “Lump Sum.”
-- • If the pledge is being paid in monthly payments, display “Monthly - #” (with the #
-- representing the number of months for payment).
-- • The list should be sorted to display all lump sum pledges first.
DECLARE
    lv_month NUMBER := 1; -- replace with your month number
    lv_year NUMBER := 2022; -- replace with your year
    CURSOR pledge_cur IS
        SELECT pledge_id, donor_id, pledge_amount, payment_type, payment_months
        FROM pledges
        WHERE EXTRACT(MONTH FROM pledge_date) = lv_month
          AND EXTRACT(YEAR FROM pledge_date) = lv_year
        ORDER BY CASE WHEN payment_type = 'Lump Sum' THEN 1 ELSE 2 END;
    pledge_rec pledge_cur%ROWTYPE;
BEGIN
    OPEN pledge_cur;
    LOOP
        FETCH pledge_cur INTO pledge_rec;
        EXIT WHEN pledge_cur%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || pledge_rec.pledge_id);
        DBMS_OUTPUT.PUT_LINE('Donor ID: ' || pledge_rec.donor_id);
        DBMS_OUTPUT.PUT_LINE('Pledge Amount: ' || pledge_rec.pledge_amount);
        IF pledge_rec.payment_type = 'Lump Sum' THEN
            DBMS_OUTPUT.PUT_LINE('Payment Type: Lump Sum');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Payment Type: Monthly - ' || pledge_rec.payment_months);
        END IF;
        DBMS_OUTPUT.PUT_LINE('-----');
    END LOOP;
    CLOSE pledge_cur;
END;

-- Assignment 3-12: Retrieving a Specific Pledge
-- Create a PL/SQL block to retrieve and display information for a specific pledge. Display the
-- pledge ID, donor ID, pledge amount, total paid so far, and the difference between the pledged
-- amount and total paid amount.
DECLARE
    v_pledge_id NUMBER;
    v_donor_id NUMBER;
    v_pledge_amount NUMBER;
    v_total_paid NUMBER;
    v_difference NUMBER;
BEGIN
    -- Assuming you have the pledge ID, you can assign it to v_pledge_id variable.
    -- For example:
    v_pledge_id := 1;

    -- Retrieve pledge information
    SELECT idBasket, idShopper, SubTotal
    INTO v_pledge_id, v_donor_id, v_pledge_amount
    FROM bb_basket
    WHERE idBasket = v_pledge_id;

    -- Retrieve total paid for the pledge
    SELECT SUM(SubTotal)
    INTO v_total_paid
    FROM bb_basket
    WHERE idBasket = v_pledge_id;

    -- Calculate the difference between pledge amount and total paid
    v_difference := v_pledge_amount - NVL(v_total_paid, 0);

    -- Display pledge information
    DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || v_pledge_id);
    DBMS_OUTPUT.PUT_LINE('Donor ID: ' || v_donor_id);
    DBMS_OUTPUT.PUT_LINE('Pledge Amount: $' || v_pledge_amount);
    DBMS_OUTPUT.PUT_LINE('Total Paid So Far: $' || NVL(v_total_paid, 0));
    DBMS_OUTPUT.PUT_LINE('Difference: $' || v_difference);
END;

-- Assignment 3-13: Modifying Data
-- Create a PL/SQL block to modify the fundraising goal amount for a specific project. In addition,
-- display the following information for the project being modified: project name, start date,
-- previous fundraising goal amount, and new fundraising goal amount.
SET SERVEROUTPUT ON;

DECLARE
    v_project_name bb_product.productname%TYPE;
    v_start_date bb_product.salestart%TYPE;
    v_previous_goal bb_product.saleprice%TYPE;
    v_new_goal NUMBER := 1500; -- Modify this value as per your requirement
BEGIN
    -- Retrieve project information before modification
    SELECT productname, salestart, saleprice
    INTO v_project_name, v_start_date, v_previous_goal
    FROM bb_product
    WHERE idproduct = 1; -- Replace 1 with the specific project ID you want to modify

    -- Display project information before modification
    DBMS_OUTPUT.PUT_LINE('Project Name: ' || v_project_name);
    DBMS_OUTPUT.PUT_LINE('Start Date: ' || TO_CHAR(v_start_date, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Previous Fundraising Goal Amount: $' || v_previous_goal);

    -- Modify fundraising goal amount
    UPDATE bb_product
    SET saleprice = v_new_goal
    WHERE idproduct = 1; -- Replace 1 with the specific project ID you want to modify

    -- Display modified fundraising goal amount
    DBMS_OUTPUT.PUT_LINE('New Fundraising Goal Amount: $' || v_new_goal);
    
    -- Commit the transaction
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Project not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction in case of error
END;

-- CASE PROJECTS

-- Case 3-1: Using Variable Types
-- The Brewbean’s manager has just hired another programmer to help you develop application
-- code for the online store. Explain the difference between scalar, record, and table variables to
-- the new employee.

-- Case 3-2: Working with More Movie Rentals
-- The More Movie Rental Company is developing an application page that displays the total
-- number of times a specified movie has been rented and the associated rental rating based on
-- this count. Table 3-4 shows the rental ratings.
-- Create a block that retrieves the movie title and rental count based on a movie ID provided
-- via an initialized variable. The block should display the movie title, rental count, and rental rating
-- onscreen. Add exception handlers for errors you can and can’t anticipate. Run the block with
-- movie IDs of 4 and 25.
-- TABLE 3-4 Movie Rental Ratings
-- Number of Rentals Rental Rating
-- Up to 5 Dump
-- 5–20 Low
-- 21–35 Mid
-- More than 35 High
DECLARE
    v_movie_id NUMBER := 4; -- Initialize movie ID
    v_movie_title VARCHAR2(100);
    v_rental_count NUMBER;
    v_rental_rating VARCHAR2(20);

    -- Exception for anticipated errors
    CURSOR rental_cursor IS
        SELECT movie_title, COUNT(*) AS rental_count
        FROM rental_history
        WHERE movie_id = v_movie_id
        GROUP BY movie_title;

    -- Exception for unanticipated errors
    v_custom_exception EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_custom_exception, -20001);

BEGIN
    -- Retrieve movie details
    OPEN rental_cursor;
    FETCH rental_cursor INTO v_movie_title, v_rental_count;
    CLOSE rental_cursor;

    -- Determine rental rating based on rental count
    IF v_rental_count >= 10 THEN
        v_rental_rating := 'High';
    ELSIF v_rental_count >= 5 THEN
        v_rental_rating := 'Moderate';
    ELSE
        v_rental_rating := 'Low';
    END IF;

    -- Display movie details
    DBMS_OUTPUT.PUT_LINE('Movie Title: ' || v_movie_title);
    DBMS_OUTPUT.PUT_LINE('Rental Count: ' || v_rental_count);
    DBMS_OUTPUT.PUT_LINE('Rental Rating: ' || v_rental_rating);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No rental history found for the specified movie ID.');
    WHEN v_custom_exception THEN
        DBMS_OUTPUT.PUT_LINE('An unanticipated error occurred: ' || SQLERRM);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
