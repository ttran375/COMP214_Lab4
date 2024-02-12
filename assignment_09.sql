-- Assignment 3-9: Retrieving Pledge Totals
-- Create a PL/SQL block that retrieves and displays information for a specific project based on
-- Project ID. Display the following on a single row of output: project ID, project name, number of
-- pledges made, total dollars pledged, and the average pledge amount.
DECLARE
  v_project_id    NUMBER := 1; -- Replace <your_project_id> with the actual Project ID
  v_project_name  bb_department.deptname%TYPE;
  v_num_pledges   NUMBER;
  v_total_pledged NUMBER;
  v_avg_pledge    NUMBER;
BEGIN
 -- Retrieve project information
  SELECT
    d.deptname INTO v_project_name
  FROM
    bb_department d
  WHERE
    d.idDepartment = v_project_id;
 -- Retrieve number of pledges, total dollars pledged, and average pledge amount
  SELECT
    COUNT(p.idRequest),
    SUM(p.cost),
    AVG(p.cost) INTO v_num_pledges,
    v_total_pledged,
    v_avg_pledge
  FROM
    bb_product_request p
  WHERE
    p.idproduct = v_project_id;
 -- Display the information
  DBMS_OUTPUT.PUT_LINE('Project ID: '
                       || v_project_id);
  DBMS_OUTPUT.PUT_LINE('Project Name: '
                       || v_project_name);
  DBMS_OUTPUT.PUT_LINE('Number of Pledges: '
                       || v_num_pledges);
  DBMS_OUTPUT.PUT_LINE('Total Dollars Pledged: $'
                       || TO_CHAR(v_total_pledged, '99999.99'));
  DBMS_OUTPUT.PUT_LINE('Average Pledge Amount: $'
                       || TO_CHAR(v_avg_pledge, '99999.99'));
END;
/
