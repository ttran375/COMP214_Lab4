
CREATE OR REPLACE FUNCTION DD_PLSTAT_SF(
  v_status_id IN NUMBER
) RETURN VARCHAR2 IS
  v_status_desc VARCHAR2(15);
BEGIN
  CASE v_status_id
    WHEN 10 THEN
      v_status_desc := 'Open';
    WHEN 20 THEN
      v_status_desc := 'Complete';
    WHEN 30 THEN
      v_status_desc := 'Overdue';
    WHEN 40 THEN
      v_status_desc := 'Closed';
    WHEN 50 THEN
      v_status_desc := 'Hold';
    ELSE
      v_status_desc := 'Unknown';
  END CASE;

  RETURN v_status_desc;
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
