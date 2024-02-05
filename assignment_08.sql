-- Assignment 2-8: Using IF Statements
-- Create a block to accomplish the task outlined in Assignment 2-7. Include a variable containing a Y or N to indicate membership status and a variable to represent the number of items purchased. Test with a variety of values.
DECLARE
    lv_nonmember_cost NUMBER := 0.0;
    lv_member_cost NUMBER := 0.0;
    lv_quantity_of_items NUMBER := 5;
    lv_is_member CHAR := 'Y';
BEGIN
    IF lv_quantity_of_items <= 3 THEN
        lv_nonmember_cost := 5.00;
        lv_member_cost := 3.00;
    ELSIF lv_quantity_of_items <= 6 THEN
        lv_nonmember_cost := 7.50;
        lv_member_cost := 5.00;
    ELSIF lv_quantity_of_items <= 10 THEN
        lv_nonmember_cost := 10.00;
        lv_member_cost := 7.00;
    ELSE
        lv_nonmember_cost := 12.00;
        lv_member_cost := 9.00;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Quantity of Items: ' || lv_quantity_of_items);
    DBMS_OUTPUT.PUT_LINE('Is Member: ' || lv_is_member);

    IF UPPER(lv_is_member) = 'Y' THEN
        DBMS_OUTPUT.PUT_LINE('Member Shipping Cost: $' || TO_CHAR(lv_member_cost, '99.99'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nonmember Shipping Cost: $' || TO_CHAR(lv_nonmember_cost, '99.99'));
    END IF;
END;
/
