-- Assignment 3-10: Adding a Project
-- Create a PL/SQL block to handle adding a new project. Create and use a sequence named
-- DD_PROJID_SEQ to handle generating and populating the project ID. The first number issued
-- by this sequence should be 530, and no caching should be used. Use a record variable to
-- handle the data to be added. Data for the new row should be the following: project name = HK
-- Animal Shelter Extension, start = 1/1/2013, end = 5/31/2013, and fundraising goal = $65,000.
-- Any columns not addressed in the data list are currently unknown.

CREATE SEQUENCE DD_PROJID_SEQ START WITH 530 NOCACHE;

DECLARE
  TYPE PROJECT_INFO IS RECORD(
    PROJECT_NAME DD_PROJECT.PROJNAME%TYPE := 'HK Animal Shelter Extension',
    PROJECT_START DD_PROJECT.PROJSTARTDATE%TYPE := '01-JAN-13',
    PROJECT_END DD_PROJECT.PROJENDDATE%TYPE := '31-MAY-13',
    FUNDRAISING_GOAL DD_PROJECT.PROJFUNDGOAL%TYPE := '65000'
  );
  NEW_PROJECT PROJECT_INFO;
BEGIN
  INSERT INTO DD_PROJECT(
    IDPROJ,
    PROJNAME,
    PROJSTARTDATE,
    PROJENDDATE,
    PROJFUNDGOAL
  ) VALUES(
    DD_PROJID_SEQ.NEXTVAL,
    NEW_PROJECT.PROJECT_NAME,
    NEW_PROJECT. PROJECT_START,
    NEW_PROJECT.PROJECT_END,
    NEW_PROJECT.FUNDRAISING_GOAL
  );
  COMMIT;
END;
