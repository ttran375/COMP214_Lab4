-- Assignment 3-9: Retrieving Pledge Totals
-- Create a PL/SQL block that retrieves and displays information for a specific project based on
-- Project ID. Display the following on a single row of output: project ID, project name, number of
-- pledges made, total dollars pledged, and the average pledge amount.
DECLARE
  lv_project_id    NUMBER := 1;
  lv_project_name  bb_department.deptname%TYPE;
  lv_num_pledges   NUMBER;
  lv_total_pledged NUMBER;
  lv_avg_pledge    NUMBER;
BEGIN
  SELECT
    d.deptname INTO lv_project_name
  FROM
    bb_department d
  WHERE
    d.idDepartment = lv_project_id;
  SELECT
    COUNT(p.idRequest),
    SUM(p.cost),
    AVG(p.cost) INTO lv_num_pledges,
    lv_total_pledged,
    lv_avg_pledge
  FROM
    bb_product_request p
  WHERE
    p.idproduct = lv_project_id;
  DBMS_OUTPUT.PUT_LINE('Project ID: '
                       || lv_project_id);
  DBMS_OUTPUT.PUT_LINE('Project Name: '
                       || lv_project_name);
  DBMS_OUTPUT.PUT_LINE('Number of Pledges: '
                       || lv_num_pledges);
  DBMS_OUTPUT.PUT_LINE('Total Dollars Pledged: $'
                       || TO_CHAR(lv_total_pledged, '99999.99'));
  DBMS_OUTPUT.PUT_LINE('Average Pledge Amount: $'
                       || TO_CHAR(lv_avg_pledge, '99999.99'));
END;
