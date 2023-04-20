select count(*) from fact_order_lines


select * from fact_order_lines


/*select count(product_id)/c1
from (select count(product_id) as c1
      from fact_order_lines
      where In_Full = 1) as new_table, fact_order_lines

with c1 as (
select val.* from fact_order_lines as val)

 select fol.product_id
     from fact_order_lines as fol,c1
     where c1.order_id = fol.order_id
	 and c1.product_id = fol.product_id
	 and c1.customer_id = fol.customer_id
	 and fol.In_Full = 1*/

	 /*Line Fill Rate*/

with cte as (select count(*) as c1, 0 as c2
from fact_order_lines fol
union
select 0 as c1, count(*) as c2
from fact_order_lines fol
where In_Full = 1) 

select cast(round(sum(c2)* 100.00/sum(c1),2) as float)
from cte 

/* Volume Fill Rate*/

select cast(round(sum(fol.delivery_qty)*100.00/sum(fol.order_qty),2) as float) as s2
from fact_order_lines fol

	 /*Line Fill Rate by customer name*/
with cte as (select fol.customer_id,count(*) as c1, 0 as c2
from fact_order_lines fol
group by fol.customer_id
union
select fol.customer_id,0 as c1, count(product_id) as c2
from fact_order_lines fol
where In_Full = 1
group by fol.customer_id) 

select dc.customer_name,cast(round(sum(c2)* 100.00/sum(c1),2) as float)
from cte join dim_customers dc
on cte.customer_id = dc.customer_id
group by dc.customer_name

select * from dbo.dim_products

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES

select * from dim_products

select * from dbo.fact_orders_aggregate

/*total orders, total orders on time, total orders infull and total orders (on time and infull)(OTIF) */

with cte as (select count(order_id) as total_orders, 0 as total_ot, 0 as total_if, 0 as total_otif
from dbo.fact_orders_aggregate

union

select 0,count(order_id) as total_ot,0,0
from dbo.fact_orders_aggregate
where on_time=1

union

select 0,0,count(order_id) as total_if,0
from dbo.fact_orders_aggregate
where in_full=1

union 

select 0,0,0,count(order_id) as total_otif
from dbo.fact_orders_aggregate
where otif = 1)

select sum(total_orders),sum(total_ot),sum(total_if),sum(total_otif)
from cte

select customer_id from fact_orders_aggregate
select * from fact_orders_aggregate


/*total orders, total orders on time, total orders infull and total orders (on time and infull)(OTIF) by City*/

with cte as (select dc.city,count(foa.order_id) as total_orders,0 as total_ot,0 as total_if,0 as total_otif
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
group by dc.city
union
select dc.city,0,count(foa.order_id),0,0
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.on_time=1
group by dc.city
union
select dc.city,0,0,count(foa.order_id),0
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.in_full=1
group by dc.city
union
select dc.city,0,0,0,count(foa.order_id)
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.otif=1
group by dc.city)

select cte.city,sum(cte.total_orders) as Total_Orders,sum(cte.total_ot) as Total_On_Time_Orders,sum(cte.total_if) as Total_In_Full_Orders,
sum(cte.total_otif) as On_Time_In_Full_Orders
from cte
group by cte.city

/*total orders, total orders on time, total orders infull and total orders (on time and infull)(OTIF) by Customer_Name*/

with cte as (select dc.customer_name,count(foa.order_id) as total_orders,0 as total_ot,0 as total_if,0 as total_otif
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
group by dc.customer_name
union
select dc.customer_name,0,count(foa.order_id),0,0
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.on_time=1
group by dc.customer_name
union
select dc.customer_name,0,0,count(foa.order_id),0
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.in_full=1
group by dc.customer_name
union
select dc.customer_name,0,0,0,count(foa.order_id)
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.otif=1
group by dc.customer_name)

select cte.customer_name,sum(cte.total_orders) as Total_Orders,sum(cte.total_ot) as Total_On_Time_Orders,sum(cte.total_if) as Total_In_Full_Orders,
sum(cte.total_otif) as On_Time_In_Full_Orders
from cte
group by cte.customer_name

select * from dim_targets_orders

select * from dim_customers

select c.city,avg(t.ontime_target) as ot, avg(t.infull_target) as inf,avg(t.otif_target) as otif
from dim_targets_orders t
join dim_customers c
on t.customer_id = c.customer_id
group by c.city

/*total orders, total orders on time%, total orders infull% and total orders (on time and infull)(OTIF)% by City*/

with cte1 as (select dc.city,count(foa.order_id) as total_orders,0 as total_ot,0 as total_if,0 as total_otif
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
group by dc.city
union
select dc.city,0,count(foa.order_id),0,0
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.on_time=1
group by dc.city
union
select dc.city,0,0,count(foa.order_id),0
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.in_full=1
group by dc.city
union
select dc.city,0,0,0,count(foa.order_id)
from fact_orders_aggregate foa
join dim_customers dc
on foa.customer_id = dc.customer_id
and foa.otif=1
group by dc.city)



select cte1.city,sum(cte1.total_orders) as Total_Orders,cast(round((sum(cte1.total_ot)*100.00/sum(cte1.total_orders)),2) as float) as Total_On_Time_Orders,
cast(round((sum(cte1.total_if)*100.00/sum(cte1.total_orders)),2) as float) as Total_In_Full_Orders,
cast(round((sum(cte1.total_otif)*100.00/sum(cte1.total_orders)),2) as float) as On_Time_In_Full_Orders
from cte1
group by cte1.city

Exec sp_rename 'dim_targets_orders.otif_target%','otif_target'

select * from dim_targets_orders
select * from fact_orders_aggregate foa
select * from fact_order_lines
select * from dim_customers dc

/*calculate % variance between actual and target from on time (OT), infull(IF) and 'ontime and infill'(OTIF) metrics by city*/

with cte1 as (select dc.city,count(order_id) as total_orders,
cast(round(sum(case when on_time=1 then 1 else 0 end)*100.00/count(order_id),2) as float) as order_ot,
cast(round(sum(case when in_full=1 then 1 else 0 end)*100.00/count(order_id),2) as float) as order_in_full,
cast(round(sum(case when otif=1 then 1 else 0 end)*100.00/count(order_id),2) as float) as order_otif
from fact_orders_aggregate foa 
join dim_customers dc
on foa.customer_id = dc.customer_id
group by dc.city),


cte2 as (select dc.city, avg(ontime_target) as  order_ot,avg(infull_target) as order_in_full,avg(otif_target) as order_otif
from dim_targets_orders as dto 
join dim_customers dc
on dto.customer_id = dc.customer_id
group by dc.city)

select cte1.city,
round((cte1.order_ot-cte2.order_ot)*100/cte2.order_ot,3), 
round((cte1.order_in_full - cte2.order_in_full)*100/cte2.order_in_full,3), 
round((cte1.order_otif - cte2.order_otif)*100/cte2.order_otif,3)  
from cte1 join cte2 
on cte1.city = cte2.city

/*top 5 customers by total quantity ordered, in full quantity ordered and 'ontime and infull' quantity ordered order by all order types*/

select top 5 dc.customer_name,sum(order_qty) as s,
sum(case when on_time=1 then order_qty else 0 end) as order_ot,
sum(case when in_full=1 then order_qty else 0 end) as order_in_full,
sum(case when On_Time_In_Full=1 then order_qty else 0 end) as order_otif
from dim_customers dc
join fact_order_lines fol
on dc.customer_id = fol.customer_id
group by dc.customer_name
order by s desc,order_ot desc,order_in_full desc,order_otif desc

select * from fact_order_lines

/*top 5 customers by total quantity ordered, in full quantity, on time quantity ordered and 'ontime and infull' quantity ordered*/

select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id 
group by dc.customer_name
order by qty desc

select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id
and fol.In_Full = 1
group by dc.customer_name
order by qty desc

select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id
and fol.On_Time = 1
group by dc.customer_name
order by qty desc

select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id
and fol.On_Time_In_Full = 1
group by dc.customer_name
order by qty desc

/*Bottom 5 customers by total quantity ordered, in full quantity, on time quantity ordered and 'ontime and infull' quantity ordered*/

select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id 
group by dc.customer_name
order by qty 


select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id
and fol.In_Full = 1
group by dc.customer_name
order by qty 

select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id
and fol.On_Time = 1
group by dc.customer_name
order by qty 

select top 5 dc.customer_name,sum(fol.order_qty) as qty
from fact_order_lines fol
join dim_customers dc
on fol.customer_id = dc.customer_id
and fol.On_Time_In_Full = 1
group by dc.customer_name
order by qty 


/*provide actual OT%, IF%, and OTIF% by customers*/

select dc.customer_name,count(order_id) as total_orders,
cast(round(sum(case when on_time=1 then 1 else 0 end)*100.00/count(order_id),2) as float) as order_ot_percent,
cast(round(sum(case when in_full=1 then 1 else 0 end)*100.00/count(order_id),2) as float) as order_in_full_percent,
cast(round(sum(case when otif=1 then 1 else 0 end)*100.00/count(order_id),2) as float) as order_otif_percent
from fact_orders_aggregate foa 
join dim_customers dc
on foa.customer_id = dc.customer_id
group by dc.customer_name

/*categorize the orders by product category for each customer in descending order*/

with cte as (select dc.customer_name,dp.category,count(fol.order_id) as orders
from fact_order_lines fol
join dim_customers dc
on dc.customer_id = fol.customer_id
join dim_products dp
on fol.product_id = dp.product_id
group by dc.customer_name,dp.category)

select cte.customer_name,
sum(case when cte.category = 'beverages' then orders else 0 end) as beverages,
sum(case when cte.category = 'Dairy' then orders else 0 end) as Dairy,
sum(case when cte.category = 'Food' then orders else 0 end) as Food,
sum(cte.orders) as total_orders
from cte
group by cte.customer_name
order by total_orders desc

/*categorize the orders by product category for each city in descending order*/

with cte as (select dc.city,dp.category,count(fol.order_id) as orders
from fact_order_lines fol
join dim_customers dc
on dc.customer_id = fol.customer_id
join dim_products dp
on fol.product_id = dp.product_id
group by dc.city,dp.category)

select cte.city,
sum(case when cte.category = 'beverages' then orders else 0 end) as beverages,
sum(case when cte.category = 'Dairy' then orders else 0 end) as Dairy,
sum(case when cte.category = 'Food' then orders else 0 end) as Food,
sum(cte.orders) as total_orders
from cte
group by cte.city
order by total_orders desc

select * from fact_orders_aggregate
select * from fact_order_lines
select distinct customer_name from dim_customers
select * from dim_products






/*find top 3 customers from each city based on their total orders and what is their OTIF% */

with cte as (select dc.city,dc.customer_id,count(order_id) as orders, rank() over (partition by dc.city order by count(order_id) desc) as rk,
cast(round(sum(case when otif=1 then 1 else 0 end)*100.00/count(order_id),2) as float) as order_otif_percent
from dim_customers dc
join fact_orders_aggregate foa
on dc.customer_id = foa.customer_id
group by dc.city,dc.customer_id)

select city,customer_id,orders,order_otif_percent,rk
from cte
where rk in (1,2,3)

select count(product_name) from dim_products

/*which product was most and least ordered by each customer*/

with cte1 as (select dc.customer_name,dp.product_name,count(dp.product_name) as product_count,rank() over (partition by dc.customer_name order by count(dp.product_name) desc) as rk
from dim_customers dc,
fact_order_lines foa, 
dim_products dp
where dc.customer_id = foa.customer_id
and foa.product_id = dp.product_id
group by dc.customer_name,dp.product_name),

/*select distinct cte.customer_name,cte.product_name,cte.product_count,rk
from cte
where rk = 1*/

cte2 as (select dc.customer_name,dp.product_name,count(dp.product_name) as product_count,rank() over (partition by dc.customer_name order by count(dp.product_name)) as rk
from dim_customers dc,
fact_order_lines foa, 
dim_products dp
where dc.customer_id = foa.customer_id
and foa.product_id = dp.product_id
group by dc.customer_name,dp.product_name)

select cte1.customer_name,cte1.product_name,cte2.customer_name,cte2.product_name
from cte1 join cte2 on cte1.customer_name = cte2.customer_name
where cte1.rk = 1 and cte2.rk = 1

select * from dim_targets_orders


select avg(otif_target) from dim_targets_orders


