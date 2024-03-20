-- Assignment 6-11: Identifying Pledge Status
-- The DoGood Donor organization decided to reduce SQL join activity in its application by
-- eliminating the DD_STATUS table and replacing it with a function that returns a status description
-- based on the status ID value. Create this function and name it DD_PLSTAT_SF. Use the function
-- in an SQL statement that displays the pledge ID, pledge date, and pledge status for all pledges.
-- Also, use it in an SQL statement that displays the same values but for only a specified pledge.

CREATE OR REPLACE FUNCTION DD_PLSTAT_SF(
  lv_status_id IN NUMBER
) RETURN VARCHAR2 IS
  lv_status_desc VARCHAR2(15);
BEGIN
  CASE lv_status_id
    WHEN 10 THEN
      lv_status_desc := 'Open';
    WHEN 20 THEN
      lv_status_desc := 'Complete';
    WHEN 30 THEN
      lv_status_desc := 'Overdue';
    WHEN 40 THEN
      lv_status_desc := 'Closed';
    WHEN 50 THEN
      lv_status_desc := 'Hold';
    ELSE
      lv_status_desc := 'Unknown';
  END CASE;

  RETURN lv_status_desc;
END DD_PLSTAT_SF;
/

SELECT
  idPledge,
  Pledgedate,
  DD_PLSTAT_SF(idStatus) AS Pledge_Status
FROM
  dd_pledge;

SELECT
  idPledge,
  Pledgedate,
  DD_PLSTAT_SF(idStatus) AS Pledge_Status
FROM
  dd_pledge
WHERE
  idPledge = :specified_pledge_id;
