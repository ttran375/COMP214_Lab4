-- Assignment 6-10: Calculating the Total Project Pledge Amount
-- Create a function named DD_PROJTOT_SF that determines the total pledge amount for a project.
-- Use the function in an SQL statement that lists all projects, displaying project ID, project name,
-- and project pledge total amount. Format the pledge total to display zero if no pledges have been
-- made so far, and have it show a dollar sign, comma, and two decimal places for dollar values.
CREATE OR REPLACE FUNCTION DD_PROJTOT_SF(
  lv_project_id IN NUMBER
) RETURN NUMBER IS
  lv_total_pledge_amount NUMBER;
BEGIN
  SELECT
    NVL(SUM(Pledgeamt), 0) INTO lv_total_pledge_amount
  FROM
    dd_pledge
  WHERE
    idProj = lv_project_id;
  RETURN lv_total_pledge_amount;
END DD_PROJTOT_SF;
/

SELECT
  idProj,
  Projname,
  TO_CHAR(DD_PROJTOT_SF(idProj), '$999,999,999.99') AS Project_Pledge_Total
FROM
  dd_project;
