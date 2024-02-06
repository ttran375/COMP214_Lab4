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

-- Assignment 3-5: Using a WHILE Loop
-- Brewbean’s wants to include a feature in its application that calculates the total amount (quantity)
-- of a specified item that can be purchased with a given amount of money. Create a block with a
-- WHILE loop to increment the item’s cost until the dollar value is met. Test first with a total spending
-- amount of $100 and product ID 4. Then test with an amount and a product of your choice. Use
-- initialized variables to provide the total spending amount and product ID.

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

-- Assignment 3-7: Using Scalar Variables for Data Retrieval
-- The Brewbean’s application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET
-- table. Create a PL/SQL block with scalar variables to retrieve this data and then display it
-- onscreen. An initialized variable should provide the IDBASKET value. Test the block using the
-- basket ID 12.

-- Assignment 3-8: Using a Record Variable for Data Retrieval
-- The Brewbean’s application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET
-- table. Create a PL/SQL block with a record variable to retrieve this data and display it
-- onscreen. An initialized variable should provide the IDBASKET value. Test the block using
-- the basket ID 12.

-- Assignment 3-9: Retrieving Pledge Totals
-- Create a PL/SQL block that retrieves and displays information for a specific project based on
-- Project ID. Display the following on a single row of output: project ID, project name, number of
-- pledges made, total dollars pledged, and the average pledge amount.

-- Assignment 3-10: Adding a Project
-- Create a PL/SQL block to handle adding a new project. Create and use a sequence named
-- DD_PROJID_SEQ to handle generating and populating the project ID. The first number issued
-- by this sequence should be 530, and no caching should be used. Use a record variable to
-- handle the data to be added. Data for the new row should be the following: project name = HK
-- Animal Shelter Extension, start = 1/1/2013, end = 5/31/2013, and fundraising goal = $65,000.
-- Any columns not addressed in the data list are currently unknown.

-- Assignment 3-11: Retrieving and Displaying Pledge Data
-- Create a PL/SQL block to retrieve and display data for all pledges made in a specified month.
-- One row of output should be displayed for each pledge. Include the following in each row
-- of output:
-- • Pledge ID, donor ID, and pledge amount
-- • If the pledge is being paid in a lump sum, display “Lump Sum.”
-- • If the pledge is being paid in monthly payments, display “Monthly - #” (with the #
-- representing the number of months for payment).
-- • The list should be sorted to display all lump sum pledges first.

-- Assignment 3-12: Retrieving a Specific Pledge
-- Create a PL/SQL block to retrieve and display information for a specific pledge. Display the
-- pledge ID, donor ID, pledge amount, total paid so far, and the difference between the pledged
-- amount and total paid amount.
-- Assignment 3-13: Modifying Data
-- Create a PL/SQL block to modify the fundraising goal amount for a specific project. In addition,
-- display the following information for the project being modified: project name, start date,
-- previous fundraising goal amount, and new fundraising goal amount.

CASE PROJECTS

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
