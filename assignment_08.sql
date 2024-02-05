-- Assignment 2-8: Using IF Statements
-- Create a block to accomplish the task outlined in Assignment 2-7. Include a variable containing a Y or N to indicate membership status and a variable to represent the number of items purchased. Test with a variety of values.
DECLARE
    -- Declare shipping cost variables
    nonmember_cost NUMBER := 0.0;
    member_cost NUMBER := 0.0;

    -- Input parameters
    v_quantity_of_items NUMBER := 5;
    v_is_member CHAR := 'Y';
BEGIN
    -- Set shipping costs based on quantity of items
    IF v_quantity_of_items <= 3 THEN
        nonmember_cost := 5.00;
        member_cost := 3.00;
    ELSIF v_quantity_of_items <= 6 THEN
        nonmember_cost := 7.50;
        member_cost := 5.00;
    ELSIF v_quantity_of_items <= 10 THEN
        nonmember_cost := 10.00;
        member_cost := 7.00;
    ELSE
        nonmember_cost := 12.00;
        member_cost := 9.00;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Quantity of Items: ' || v_quantity_of_items);
    DBMS_OUTPUT.PUT_LINE('Is Member: ' || v_is_member);

    -- Display shipping cost based on membership status
    IF UPPER(v_is_member) = 'Y' THEN
        DBMS_OUTPUT.PUT_LINE('Member Shipping Cost: $' || TO_CHAR(member_cost, '99.99'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nonmember Shipping Cost: $' || TO_CHAR(nonmember_cost, '99.99'));
    END IF;
END;
/
