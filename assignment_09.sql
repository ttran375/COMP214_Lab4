-- Assignment 3-9: Retrieving Pledge Totals
-- Create a PL/SQL block that retrieves and displays information for a specific project based on
-- Project ID. Display the following on a single row of output: project ID, project name, number of
-- pledges made, total dollars pledged, and the average pledge amount.
DECLARE
  lv_project_id    projects.project_id%TYPE := 1;
  lv_project_name  projects.project_name%TYPE;
  lv_pledge_count  NUMBER;
  lv_total_pledged NUMBER;
  lv_avg_pledge    NUMBER;
BEGIN
  SELECT
    p.project_name,
    COUNT(pl.pledge_id),
    SUM(pl.pledge_amount),
    AVG(pl.pledge_amount) INTO lv_project_name,
    lv_pledge_count,
    lv_total_pledged,
    lv_avg_pledge
  FROM
    projects p
    JOIN pledges pl
    ON p.project_id = pl.project_id
  WHERE
    p.project_id = lv_project_id
  GROUP BY
    p.project_name;
  DBMS_OUTPUT.PUT_LINE('Project ID: '
                       || lv_project_id);
  DBMS_OUTPUT.PUT_LINE('Project Name: '
                       || lv_project_name);
  DBMS_OUTPUT.PUT_LINE('Number of Pledges: '
                       || lv_pledge_count);
  DBMS_OUTPUT.PUT_LINE('Total Dollars Pledged: '
                       || lv_total_pledged);
  DBMS_OUTPUT.PUT_LINE('Average Pledge Amount: '
                       || lv_avg_pledge);
END;
