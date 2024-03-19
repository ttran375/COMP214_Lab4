-- Assignment 7-6: Creating a Package with Only a Specification
-- In this assignment, you create a package consisting of only a specification. The Brewbean’s
-- lead programmer has noticed that only a few states require Internet sales tax, and the rates
-- don’t change often. Create a package named TAX_RATE_PKG to hold the following tax rates in
-- packaged variables for reference: pv_tax_nc = .035, pv_tax_tx = .05, and pv_tax_tn = .02.
-- Code the variables to prevent the rates from being modified. Use an anonymous block with
-- DBMS_OUTPUT statements to display the value of each packaged variable.
-- create a reference package w/ no body
CREATE OR REPLACE PACKAGE tax_rate_pkg IS
  pv_tax_nc CONSTANT NUMBER := .035; -- all variables are constants
  pv_tax_tx CONSTANT NUMBER := .05;
  pv_tax_tn CONSTANT NUMBER := .02;
END;
/

-- test our body-less package by printing the variables
BEGIN
  dbms_output.put_line(tax_rate_pkg.pv_tax_nc);
  dbms_output.put_line(tax_rate_pkg.pv_tax_tx);
  dbms_output.put_line(tax_rate_pkg.pv_tax_tn);
END;
/
