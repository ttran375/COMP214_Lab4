-- Assignment 3-10: Adding a Project
-- Create a PL/SQL block to handle adding a new project. Create and use a sequence named
-- DD_PROJID_SEQ to handle generating and populating the project ID. The first number issued
-- by this sequence should be 530, and no caching should be used. Use a record variable to
-- handle the data to be added. Data for the new row should be the following: project name = HK
-- Animal Shelter Extension, start = 1/1/2013, end = 5/31/2013, and fundraising goal = $65,000.
-- Any columns not addressed in the data list are currently unknown.
CREATE SEQUENCE DD_PROJID_SEQ
  START WITH 530
  INCREMENT BY 1
  NOCACHE;

DECLARE
  TYPE project_rec_type IS RECORD (
    project_id NUMBER,
    project_name VARCHAR2(100),
    start_date DATE,
    end_date DATE,
    fundraising_goal NUMBER
  );
  project_rec project_rec_type;
BEGIN
  project_rec.project_id := DD_PROJID_SEQ.NEXTVAL;
  project_rec.project_name := 'HK Animal Shelter Extension';
  project_rec.start_date := TO_DATE('1/1/2013', 'MM/DD/YYYY');
  project_rec.end_date := TO_DATE('5/31/2013', 'MM/DD/YYYY');
  project_rec.fundraising_goal := 65000;
  INSERT INTO projects (
    project_id,
    project_name,
    start_date,
    end_date,
    fundraising_goal
  ) VALUES (
    project_rec.project_id,
    project_rec.project_name,
    project_rec.start_date,
    project_rec.end_date,
    project_rec.fundraising_goal
  );
  COMMIT;
END;
