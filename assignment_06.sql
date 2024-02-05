-- Assignment 2-6: Using Looping Statements
-- Create a block using a loop that determines the number of items that can be purchased based on the item prices and the total available to spend. Include one initialized variable to represent the price and another to represent the total available to spend. (You could solve it with division, but you need to practice using loop structures.) The block should include statements to display the total number of items that can be purchased and the total amount spent.
DECLARE
  vItemPrice NUMBER := 50; -- Initialize with the price of one item
  vTotalAvailable NUMBER := 300; -- Initialize with the total amount available to spend
  vItemsPurchased NUMBER := 0; -- Initialize the count of items purchased

BEGIN
  -- Loop to determine the number of items that can be purchased
  WHILE vTotalAvailable >= vItemPrice LOOP
    vItemsPurchased := vItemsPurchased + 1;
    vTotalAvailable := vTotalAvailable - vItemPrice;
  END LOOP;

  -- Display the results
  DBMS_OUTPUT.PUT_LINE('Item Price: ' || vItemPrice);
  DBMS_OUTPUT.PUT_LINE('Total Available: ' || vTotalAvailable);
  DBMS_OUTPUT.PUT_LINE('Total items purchased: ' || vItemsPurchased);
  DBMS_OUTPUT.PUT_LINE('Total amount spent: ' || (vItemsPurchased * vItemPrice));
END;
/
