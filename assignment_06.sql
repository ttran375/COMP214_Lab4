-- Assignment 2-6: Using Looping Statements
-- Create a block using a loop that determines the number of items that can be purchased based on the item prices and the total available to spend. Include one initialized variable to represent the price and another to represent the total available to spend. (You could solve it with division, but you need to practice using loop structures.) The block should include statements to display the total number of items that can be purchased and the total amount spent.
DECLARE
    lv_item_price NUMBER := 50;
    lv_total_available NUMBER := 320;
    lv_items_purchased NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Item Price: ' || lv_item_price);
    DBMS_OUTPUT.PUT_LINE('Total Available: ' || lv_total_available);

    WHILE lv_total_available >= lv_item_price LOOP
        lv_items_purchased := lv_items_purchased + 1;
        lv_total_available := lv_total_available - lv_item_price;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total items purchased: ' || lv_items_purchased);
    DBMS_OUTPUT.PUT_LINE('Total amount spent: ' || (lv_items_purchased * lv_item_price));
END;
/
