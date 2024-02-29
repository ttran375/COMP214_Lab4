# Assignment 2-2: Creating a Flowchart 

The Brewbean’s application needs a block that determines whether a customer is rated high, mid, or low based on his or her total purchases. The block needs to determine the rating and then display the results onscreen. The code rates the customer high if total purchases are greater than $200, mid if greater than $100, and low if $100 or lower. Develop a flowchart to outline the conditional processing steps needed for this block.

## Brewbean's Customer Rating Based Flowchart

``` txt
Start
|
v
[Declare TOTAL_PURCHASES, HIGH_LIMIT, MID_LIMIT]
|
v
[Initialize TOTAL_PURCHASES to 150]
|
v
[Display "Enter Total Purchases: 150"]
|
v
[Check if TOTAL_PURCHASES > HIGH_LIMIT]
|
v
|-----[True]
|       |
|       v
|       [Display "Customer Rated High"]
|       |
|       v
|       [Display "High Rating"]
|       |
|       v
|       [Display "End of Flowchart"]
|
|-----[False]
|       |
|       v
|       [Check if TOTAL_PURCHASES > MID_LIMIT]
|       |
|       v
|       |-----[True]
|       |       |
|       |       v
|       |       [Display "Customer Rated Mid"]
|       |       |
|       |       v
|       |       [Display "Mid Rating"]
|       |       |
|       |       v
|       |       [Display "End of Flowchart"]
|       |
|       |-----[False]
|               |
|               v
|               [Display "Customer Rated Low"]
|               |
|               v
|               [Display "Low Rating"]
|               |
|               v
|               [Display "End of Flowchart"]
|
v
[End]
```
