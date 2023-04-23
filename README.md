# Supply-Chain-FMCG-Data-Analysis

## Orders and Lines 

-> Orders are nothing but a unique request placed by a customer on a given date\
-> Within an order, a customer could request multiple items. Each of these items 
requested within the order is called an order line
Example: Let's say you order 4 notebooks and 2 pens at Amazon. A unique order ID is 
generated for all these items. Notebook and Pen is an order line.

 ## Measuring Line Fill Rate & Volume Fill Rate
 -> Line Fill Rate is an important metric for the supply planning team to understand how 
many lines they shipped out of the total lines ordered. This metric does not consider the 
delivery time of the order

-> Volume fill rate or case fill rate is a similar metric useful for the supply planning team to 
understand the total quantity they are able to ship for a customer per order or for a given 
period of time.\
Example: In above example let's say Amazon is able to ship you 4 notebooks and 1 pen. 
The line item pen is failed because you requested 2 nos. So Line Fill Rate for Amazon for 
your order is order lines fulfilled / lines ordered => 1/2 => 50 %.
Volume Fill rate will be total quantity shipped / total quantity ordered => 5/6 => 83 %.

## Measuring On Time delivery %

-> Unlike Line Fill Rate, this measure is measured at the order level. It determines if 
an order is delivered as per the agreed time with the customer.

-> This metric is important for the warehouse & distribution team.\
-> An order is On Time only when all the line items inside the order is delivered on 
time.

## Measuring In Full delivery %

-> Unlike Line Fill Rate, this measure is measured at the order level. It determines if an 
order is delivered in full as per the requested quantity by the customer.

-> This metric is important for the supply planning team.\
-> An order is In Full only when all the line items inside the order are delivered In Full.

## Measuring On Time In Full (OTIF)  %

-> Unlike Line Fill Rate, this measure is measured at the order level. It determines if an 
order is delivered BOTH in full and On Time as per the customer order request.

-> This metric is important for all the sub functions in the supply chain team.

-> An order is OTIF only when all the line items inside the order are delivered In Full 
and ON Time. This is a hard metric which measures the reliability of an order from 
customer's point of view.

## Dataset Tables

->dim_customers\
->dim_dates\
->dim_products\
->dim_targets_orders\
->dim_order_lines\
->fact_orders_aggregate



## Data Model





![Screenshot (329)](https://user-images.githubusercontent.com/59529237/233276743-56336782-b729-4dbe-b964-b24e795eb0ca.png)

## Objectives

->Line Fill Rate/Volume Fill Rate.\
->Line Fill Rate by Customer Name.\
->Volume Fill Rate by Customer Name.\
->Total Orders, Total On-time Orders, Total In-Full Orders,On-time In-Full Orders by city.\
->Total Orders, Total On-time Orders, Total In-Full Orders,On-time In-Full Orders by Customer Name.\
->Calculate % variance between actual and target on-time(OT),in-full(IF) and on-time infull(OTIF) metrics by city.\
->Top Customers by total Quantity Ordered, Infull Quantity Ordered and on-time Infull Quantity Ordered ordered by all order types.\
->Bottom Customers by total Quantity Ordered, Infull Quantity Ordered and on-time Infull Quantity Ordered ordered by all order types.\
-> Calculate actual OT%, IF%, OTIF% by Customers.\
->Categorise the orders by product category for each customer in descending order.\
->Most & Least Ordered Product by Customers.

## Power BI Visualization

https://drive.google.com/drive/folders/1Bi_2yc69PtU7HEFbQ-5Y-YxPUKiSdMgL





