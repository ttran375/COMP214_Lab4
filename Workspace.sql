-- Assignment 7-6: Creating a Package with Only a Specification
-- In this assignment, you create a package consisting of only a specification. The Brewbean’s
-- lead programmer has noticed that only a few states require Internet sales tax, and the rates
-- don’t change often. Create a package named TAX_RATE_PKG to hold the following tax rates in
-- packaged variables for reference: pv_tax_nc = .035, pv_tax_tx = .05, and pv_tax_tn = .02.
-- Code the variables to prevent the rates from being modified. Use an anonymous block with
-- DBMS_OUTPUT statements to display the value of each packaged variable.

-- Create a package consisting of only a specification
CREATE OR REPLACE PACKAGE TAX_RATE_PKG IS
  -- Hold the tax rates in packaged variables that prevent the rates from being modified
  pv_tax_nc CONSTANT NUMBER := .035;
  pv_tax_tx CONSTANT NUMBER := .05;
  pv_tax_tn CONSTANT NUMBER := .02;
END;
/

-- Display the value of each packaged variable
BEGIN
  DBMS_OUTPUT.PUT_LINE(TAX_RATE_PKG.pv_tax_nc);
  DBMS_OUTPUT.PUT_LINE(TAX_RATE_PKG.pv_tax_tx);
  DBMS_OUTPUT.PUT_LINE(TAX_RATE_PKG.pv_tax_tn);
END;
/
