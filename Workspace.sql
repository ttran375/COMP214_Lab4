-- Assignment 7-7: Using a Cursor in a Package
-- In this assignment, you work with the sales tax computation because the Brewbean’s lead
-- programmer expects the rates and states applying the tax to undergo some changes. The tax
-- rates are currently stored in packaged variables but need to be more dynamic to handle the
-- expected changes. The lead programmer has asked you to develop a package that holds the
-- tax rates by state in a packaged cursor. The BB_TAX table is updated as needed to reflect
-- which states are applying sales tax and at what rates. This package should contain a function
-- that can receive a two-character state abbreviation (the shopper’s state) as an argument, and it
-- must be able to find a match in the cursor and return the correct tax rate. Use an anonymous
-- block to test the function with the state value NC.
-- create a tax package
CREATE OR REPLACE PACKAGE tax_rate_pkg IS
 -- spec a cursor to hold state and tax rate
  CURSOR cur_tax IS
  SELECT
    taxrate,
    state
  FROM
    bb_tax;
 -- spec a functionto get tax rate
  FUNCTION get_tax (
    pv_state IN bb_tax.state%type
  ) RETURN bb_tax.taxrate%type;
END;
/

-- create a tax package body
CREATE OR REPLACE PACKAGE BODY tax_rate_pkg IS
 -- define our function
  FUNCTION get_tax (
    pv_state IN bb_tax.state%type
  ) RETURN bb_tax.taxrate%type IS
 -- we need a holding variable for the tax rate
    pv_tax bb_tax.taxrate%type := 0.00;
  BEGIN -- use cursor for loop to find state and rate
    FOR rec_tax IN cur_tax LOOP
      IF rec_tax.state = pv_state THEN
        pv_tax := rec_tax.taxrate;
      END IF;
    END LOOP;
 -- return the rate
    RETURN pv_tax;
  END get_tax;
END;
/

-- test our package with NC
BEGIN
  dbms_output.put_line('NC'
                       ||' '
                       ||tax_rate_pkg.get_tax('NC'));
END;
/
