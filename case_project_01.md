# Case 3-1: Using Variable Types

The Brewbean’s manager has just hired another programmer to help you develop application
code for the online store. Explain the difference between scalar, record, and table variables to
the new employee.

1. **Scalar Variables:**
   - **Definition:** Scalar variables hold a single value of a specific data type.
   - **Example:** In your provided code, variables like `lv_ship_date`, `lv_shipper_txt`, `lv_ship_num`, and `lv_bask_num` are scalar variables.
   - **Usage:** Scalar variables are typically used to store individual data elements, such as numbers, strings, or dates.

2. **Record Variables:**
   - **Definition:** Record variables are used to store a collection of related data items as a single unit, similar to a row in a table.
   - **Example:** In your code, `rec_ship` is a record variable, storing multiple fields such as `dtstage`, `shipper`, and `shippingnum`.
   - **Usage:** Record variables are useful when you want to group related data together, and they often correspond to a row in a database table.

3. **Table Variables:**
   - **Definition:** Table variables hold a collection of data as if it were a small, in-memory table.
   - **Example:** In your code, you don't explicitly use table variables, but they would be useful if you needed to handle multiple rows of data, possibly from a result set or a set of records.
   - **Usage:** Table variables are beneficial when dealing with sets of related data, and they are often used to simplify operations on sets of rows.

**Summary:**

- **Scalar variables** are used for individual values.
- **Record variables** group related data together and are similar to a row in a table.
- **Table variables** are used to handle collections of data and are analogous to in-memory tables.

In the context of your Brewbean's application, scalar variables might be used for individual pieces of information (like a date or a quantity), record variables for groups of related data (like shipping information for an order), and table variables for handling sets of data (such as multiple orders or customer information).
