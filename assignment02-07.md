# Assignment 2-7: Creating a Flowchart

Brewbean’s determines shipping costs based on the number of items ordered and club membership status. The applicable rates are shown in the following chart. Develop a flowchart to outline the condition-processing steps needed to handle this calculation.

| Quantity of Items | Nonmember Shipping Cost | Member Shipping Cost |
|-------------------|--------------------------|----------------------|
| Up to 3            | $5.00                    | $3.00                |
| 4–6               | $7.50                    | $5.00                |
| 7–10              | $10.00                   | $7.00                |
| More than 10      | $12.00                   | $9.00                |

## Brewbean's Shipping Cost Calculation Flowchart

``` txt
Start
|
v
[Declare QUANTITY_OF_ITEMS, NONMEMBER_COST, MEMBER_COST, IS_MEMBER]
|
v
[Initialize QUANTITY_OF_ITEMS to 5, IS_MEMBER to False]
|
v
[Display "Enter Quantity of Items: 5"]
|
v
[Display "Are you a Club Member? (Yes/No)"]
|
v
[Check if QUANTITY_OF_ITEMS <= 3]
|
v
|-----[True]
|       |
|       v
|       [Check if IS_MEMBER is True]
|       |
|       v
|       |-----[True]
|       |       |
|       |       v
|       |       [Display "Member Shipping Cost: $3.00"]
|       |       |
|       |       v
|       |       [Display "End of Flowchart"]
|       |
|       |-----[False]
|       |       |
|       |       v
|       |       [Display "Nonmember Shipping Cost: $5.00"]
|       |       |
|       |       v
|       |       [Display "End of Flowchart"]
|
|-----[False]
|       |
|       v
|       [Check if QUANTITY_OF_ITEMS <= 6]
|       |
|       v
|       |-----[True]
|       |       |
|       |       v
|       |       [Check if IS_MEMBER is True]
|       |       |
|       |       v
|       |       |-----[True]
|       |       |       |
|       |       |       v
|       |       |       [Display "Member Shipping Cost: $5.00"]
|       |       |       |
|       |       |       v
|       |       |       [Display "End of Flowchart"]
|       |       |
|       |       |-----[False]
|       |       |       |
|       |       |       v
|       |       |       [Display "Nonmember Shipping Cost: $7.50"]
|       |       |       |
|       |       |       v
|       |       |       [Display "End of Flowchart"]
|       |
|       |-----[False]
|               |
|               v
|               [Check if QUANTITY_OF_ITEMS <= 10]
|               |
|               v
|               |-----[True]
|               |       |
|               |       v
|               |       [Check if IS_MEMBER is True]
|               |       |
|               |       v
|               |       |-----[True]
|               |       |       |
|               |       |       v
|               |       |       [Display "Member Shipping Cost: $7.00"]
|               |       |       |
|               |       |       v
|               |       |       [Display "End of Flowchart"]
|               |       |
|               |       |-----[False]
|               |       |       |
|               |       |       v
|               |       |       [Display "Nonmember Shipping Cost: $10.00"]
|               |       |       |
|               |       |       v
|               |       |       [Display "End of Flowchart"]
|               |
|               |-----[False]
|                       |
|                       v
|                       [Check if IS_MEMBER is True]
|                       |
|                       v
|                       |-----[True]
|                       |       |
|                       |       v
|                       |       [Display "Member Shipping Cost: $9.00"]
|                       |       |
|                       |       v
|                       |       [Display "End of Flowchart"]
|                       |
|                       |-----[False]
|                               |
|                               v
|                               [Display "Nonmember Shipping Cost: $12.00"]
|                               |
|                               v
|                               [Display "End of Flowchart"]
|
v
[End]
```
