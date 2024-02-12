-- Assignment 3-13: Modifying Data
-- Create a PL/SQL block to modify the fundraising goal amount for a specific project. In addition,
-- display the following information for the project being modified: project name, start date,
-- previous fundraising goal amount, and new fundraising goal amount.
SET SERVEROUTPUT ON;

DECLARE
  v_project_name  bb_product.productname%TYPE;
  v_start_date    bb_product.salestart%TYPE;
  v_previous_goal bb_product.saleprice%TYPE;
  v_new_goal      NUMBER := 1500;
BEGIN
  SELECT
    productname,
    salestart,
    saleprice INTO v_project_name,
    v_start_date,
    v_previous_goal
  FROM
    bb_product
  WHERE
    idproduct = 1;
  DBMS_OUTPUT.PUT_LINE('Project Name: '
                       || v_project_name);
  DBMS_OUTPUT.PUT_LINE('Start Date: '
                       || TO_CHAR(v_start_date, 'DD-MON-YYYY'));
  DBMS_OUTPUT.PUT_LINE('Previous Fundraising Goal Amount: $'
                       || v_previous_goal);
  UPDATE bb_product
  SET
    saleprice = v_new_goal
  WHERE
    idproduct = 1;
  DBMS_OUTPUT.PUT_LINE('New Fundraising Goal Amount: $'
                       || v_new_goal);
  COMMIT;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Project not found.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: '
                         || SQLERRM);
    ROLLBACK;
END;
