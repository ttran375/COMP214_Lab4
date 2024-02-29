-- Assignment 5-7: Identifying Customers
-- Brewbean’s wants to offer an incentive of free shipping to customers who haven’t returned to
-- the site since a specified date. Create a procedure named PROMO_SHIP_SP that determines
-- who these customers are and then updates the BB_PROMOLIST table accordingly. The
-- procedure uses the following information:
-- • Date cutoff—Any customers who haven’t shopped on the site since this date
-- should be included as incentive participants. Use the basket creation date to
-- reflect shopper activity dates.
-- • Month—A three-character month (such as APR) should be added to the promotion
-- table to indicate which month free shipping is effective.
-- • Year—A four-digit year indicates the year the promotion is effective.
-- • promo_flag—1 represents free shipping.
-- The BB_PROMOLIST table also has a USED column, which contains the default value N
-- and is updated to Y when the shopper uses the promotion. Test the procedure with the cutoff
-- date 15-FEB-12. Assign free shipping for the month APR and the year 2012.

CREATE OR REPLACE PROCEDURE PROMO_SHIP_SP (
  p_cutoff_date IN DATE,
  p_month IN VARCHAR2,
  p_year IN NUMBER
) AS
BEGIN
 -- Identify customers who haven't shopped since the cutoff date
  FOR customer IN (
    SELECT
      DISTINCT bs.IDSHOPPER
    FROM
      BB_BASKET bs
    WHERE
      bs.DTCREATED < p_cutoff_date
      AND NOT EXISTS (
        SELECT
          1
        FROM
          BB_BASKET bs2
        WHERE
          bs2.IDSHOPPER = bs.IDSHOPPER
          AND bs2.DTCREATED > p_cutoff_date
      )
  ) LOOP
 -- Update BB_PROMOLIST for each eligible customer
    INSERT INTO BB_PROMOLIST (
      IDSHOPPER,
      MONTH,
      YEAR,
      PROMO_FLAG,
      USED
    ) VALUES (
      customer.IDSHOPPER,
      p_month,
      p_year,
      1,
      'N'
    );
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Promotion records updated successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: '
                         || SQLERRM);
END;
/

BEGIN
  PROMO_SHIP_SP(TO_DATE('15-FEB-12', 'DD-MON-YYYY'), 'APR', 2012);
END;
