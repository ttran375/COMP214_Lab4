-- - Assignment 2-1: Using Scalar Variables
DECLARE
 lv_test_date DATE := '10-DEC-2012';
 lv_test_num NUMBER(3) := 10;
 lv_test_txt VARCHAR2(10);
BEGIN
 lv_test_txt := '???????';
 DBMS_OUTPUT.PUT_LINE(lv_test_date);
 DBMS_OUTPUT.PUT_LINE(lv_test_num);
 DBMS_OUTPUT.PUT_LINE(lv_test_txt);
END;
-- - Assignment 2-2: Creating a Flowchart
-- - Assignment 2-3: Using IF Statements
DECLARE
 lv_total_num NUMBER(6,2) := 150;
BEGIN
 IF lv_total_num > 200 THEN
 DBMS_OUTPUT.PUT_LINE('HIGH');
 ELSIF lv_total_num > 100 THEN
 DBMS_OUTPUT.PUT_LINE('MID');
 ELSE
 DBMS_OUTPUT.PUT_LINE('LOW');
 END IF;
END;
-- - Assignment 2-4: Using CASE Statements

DECLARE
 lv_total_num NUMBER(6,2) := 150;
BEGIN
 CASE
 WHEN lv_total_num > 200 THEN
 DBMS_OUTPUT.PUT_LINE('HIGH');
 WHEN lv_total_num > 100 THEN
 DBMS_OUTPUT.PUT_LINE('MID');
 ELSE
 DBMS_OUTPUT.PUT_LINE('LOW');
 END CASE;
END; 

-- - Assignment 2-5: Using a Boolean Variable
DECLARE
 lv_bal_num NUMBER(8,2) := 150.50;
 lv_pay_num NUMBER(8,2) := 95.00;
 lv_due_bln BOOLEAN;
BEGIN
 IF (lv_bal_num - lv_pay_num) > 0 THEN
 lv_due_bln := TRUE;
 DBMS_OUTPUT.PUT_LINE('Balance Due');
 ELSE
 lv_due_bln := FALSE;
 DBMS_OUTPUT.PUT_LINE('Account Fully Paid');
 END IF;
END;
-- - Assignment 2-6: Using Looping Statements
DECLARE
 lv_total_num NUMBER(6,2) := 200;
 lv_price_num NUMBER(5,2) := 32;
 lv_spent_num NUMBER(6,2) := 0;
 lv_qty_num NUMBER(6) := 0;
BEGIN
 WHILE (lv_spent_num + lv_price_num) < lv_total_num LOOP
 lv_spent_num := lv_spent_num + lv_price_num;
 lv_qty_num := lv_qty_num + 1;
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('Total Spent = ' || lv_spent_num);
 DBMS_OUTPUT.PUT_LINE('# purchase = ' || lv_qty_num);
END; 
-- - Assignment 2-7: Creating a Flowchart
-- - Assignment 2-8: Using IF Statements
DECLARE
 lv_mem_txt CHAR(1) := 'Y';
 lv_qty_num NUMBER(3) := 8;
 lv_ship_num NUMBER(6,2);
BEGIN
 IF lv_mem_txt = 'Y' THEN
 IF lv_qty_num > 10 THEN
 lv_ship_num := 9;
 ELSIF lv_qty_num >= 7 THEN
 lv_ship_num := 7;
 ELSIF lv_qty_num >= 4 THEN
 lv_ship_num := 5;
 ELSE
 lv_ship_num := 3;
 END IF;
 ELSE
 IF lv_qty_num > 10 THEN
 lv_ship_num := 12;
 ELSIF lv_qty_num >= 7 THEN
 lv_ship_num := 10;
 ELSIF lv_qty_num >= 4 THEN
 lv_ship_num := 7.50;
 ELSE
 lv_ship_num := 5;
 END IF;
 END IF;
 DBMS_OUTPUT.PUT_LINE(lv_ship_num);
END;
-- - Assignment 2-9: Using a FOR Loop
DECLARE
 lv_start_date DATE := '01-OCT-2012';
 lv_payamt_num NUMBER(8,2) := 20;
 lv_paymths_num NUMBER(8,2) := 24;
 lv_bal_num NUMBER(8,2) := 0;
 lv_duedate_date DATE;
 lv_duedate_txt VARCHAR2(25);
BEGIN
 lv_bal_num := lv_payamt_num * lv_paymths_num;
 lv_duedate_date := lv_start_date;
 FOR i IN 1..lv_paymths_num LOOP
 lv_bal_num := lv_bal_num - lv_payamt_num;
 lv_duedate_txt := TO_CHAR(lv_duedate_date,'mm/dd/yyyy');
 DBMS_OUTPUT.PUT_LINE('Pay #: ' || i || ' Due: ' || lv_duedate_txt
 || ' Amt: ' || TO_CHAR(lv_payamt_num,'$999.99')
 || ' Bal: ' || TO_CHAR(lv_bal_num,'$9,999.99'));
 lv_duedate_date := ADD_MONTHS(lv_duedate_date,1);
 END LOOP;
END;
-- - Assignment 2-10: Using a Basic Loop
DECLARE
 lv_start_date DATE := '01-OCT-2012';
 lv_payamt_num NUMBER(8,2) := 20;
 lv_paymths_num NUMBER(8,2) := 24;
 lv_bal_num NUMBER(8,2) := 0;
 lv_duedate_date DATE;
 lv_duedate_txt VARCHAR2(25);
 lv_cnt_num NUMBER(2) := 1;
BEGIN
 lv_bal_num := lv_payamt_num * lv_paymths_num;
 lv_duedate_date := lv_start_date;
 LOOP
 lv_bal_num := lv_bal_num - lv_payamt_num; 
 lv_duedate_txt := TO_CHAR(lv_duedate_date,'mm/dd/yyyy');
 DBMS_OUTPUT.PUT_LINE('Pay #: ' || lv_cnt_num || ' Due: ' ||
lv_duedate_txt
 || ' Amt: ' || TO_CHAR(lv_payamt_num,'$999.99')
 || ' Bal: ' || TO_CHAR(lv_bal_num,'$9,999.99'));
 lv_duedate_date := ADD_MONTHS(lv_duedate_date,1);
 EXIT WHEN (lv_cnt_num = lv_paymths_num);
 lv_cnt_num := lv_cnt_num + 1;
 END LOOP;
END;
