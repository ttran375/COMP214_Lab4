-- Assignment 3-13: Modifying Data
-- Create a PL/SQL block to modify the fundraising goal amount for a specific project. In addition,
-- display the following information for the project being modified: project name, start date,
-- previous fundraising goal amount, and new fundraising goal amount.
DECLARE
  lv_project_id           NUMBER := 502; -- Replace with the desired project ID
  lv_new_goal_amount      NUMBER := 120000; -- Replace with the new fundraising goal amount
  lv_project_info         DD_Project%ROWTYPE;
  lv_previous_goal_amount NUMBER;
BEGIN
 -- Retrieve project information
  SELECT
    * INTO lv_project_info
  FROM
    DD_Project
  WHERE
    idProj = lv_project_id;
 -- Save the previous goal amount
  lv_previous_goal_amount := lv_project_info.Projfundgoal;
 -- Modify the fundraising goal amount
  UPDATE DD_Project
  SET
    Projfundgoal = lv_new_goal_amount
  WHERE
    idProj = lv_project_id;
 -- Display project details
  DBMS_OUTPUT.PUT_LINE('Project Name: '
                       || lv_project_info.Projname
                       || ', Start Date: '
                       || lv_project_info.Projstartdate
                       || ', Previous Goal Amount: '
                       || lv_previous_goal_amount
                       || ', New Goal Amount: '
                       || lv_new_goal_amount);
END;
