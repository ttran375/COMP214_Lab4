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

create or replace package tax_rate_pkg is
  -- Hold state and tax rate in a cursor
  cursor cur_tax is
    select taxrate, state
    from bb_tax;
  -- Spec a function to get tax rate 
  function get_tax
    (pv_state in bb_tax.state%type)
    return bb_tax.taxrate%type;

end;
/

create or replace package body tax_rate_pkg is
  function get_tax
    (pv_state in bb_tax.state%type)
    return bb_tax.taxrate%type
   is
    -- we need a holding variable for the tax rate
    pv_tax bb_tax.taxrate%type := 0.00;
  begin -- use cursor for loop to find state and rate
    for rec_tax in cur_tax loop
        if rec_tax.state = pv_state then
          pv_tax := rec_tax.taxrate;
        
        end if;
    end loop;
    
    -- return the rate
    return pv_tax;
    
  end get_tax;

end;
/

-- test our package with NC
begin
  dbms_output.put_line('NC'||' '||tax_rate_pkg.get_tax('NC'));
end;
/
