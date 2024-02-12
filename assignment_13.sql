-- Assignment 3-13: Modifying Data
-- Create a PL/SQL block to modify the fundraising goal amount for a specific project. In addition,
-- display the following information for the project being modified: project name, start date,
-- previous fundraising goal amount, and new fundraising goal amount.
DECLARE
  v_project_id           NUMBER := 502; -- Replace with the desired project ID
  v_new_goal_amount      NUMBER := 120000; -- Replace with the new fundraising goal amount
  v_project_info         DD_Project%ROWTYPE;
  v_previous_goal_amount NUMBER;
BEGIN
 -- Retrieve project information
  SELECT
    * INTO v_project_info
  FROM
    DD_Project
  WHERE
    idProj = v_project_id;
 -- Save the previous goal amount
  v_previous_goal_amount := v_project_info.Projfundgoal;
 -- Modify the fundraising goal amount
  UPDATE DD_Project
  SET
    Projfundgoal = v_new_goal_amount
  WHERE
    idProj = v_project_id;
 -- Display project details
  DBMS_OUTPUT.PUT_LINE('Project Name: '
                       || v_project_info.Projname
                       || ', Start Date: '
                       || v_project_info.Projstartdate
                       || ', Previous Goal Amount: '
                       || v_previous_goal_amount
                       || ', New Goal Amount: '
                       || v_new_goal_amount);
END;
