SELECT * FROM "Walmart_sales"

--Total no of rows
select count(*) from "Walmart_sales"

--distinct payment method
select distinct payment_method from "Walmart_sales"

--using group by payment method 
select payment_method,
        count(*) 
	  from "Walmart_sales"
	  group by payment_method


--quantity
select max(quantity),
       min(quantity),
	   sum(quantity),
	   avg(quantity)
	   from "Walmart_sales"

--business method
--find difference payment method and number of transaction,number of qty sold
select payment_method,
        count(*),
		sum(quantity) as t_qty_sold
	  from "Walmart_sales"
	  group by payment_method

--identify the highest-rated category in each brand,displaying the branch,category
--avg rating
select * from "Walmart_sales"

select * from
     (  select branch,
       category,
	   avg(rating) as avg_rating,


	   rank() over(partition by branch order by avg(rating) desc ) as rnk
	   from "Walmart_sales"
	   group by branch,category 
	   ) t
where rnk=1


--identify the bussiest day for each branch based on the number of transaction
select *
from
(   
        select branch,
		To_Char(To_Date(date,'DD\MM\YY'),'Day') As day_name,
		count(*) as no_transaction,
		rank() over(partition by branch order by count(*) desc) as rnk
		from "Walmart_sales"
		group by branch,To_Char(To_Date(date,'DD\MM\YY'),'Day') 
		)t
where rnk=1


--total quantity of item sold per payment method.list payment_method and total_quantity
select payment_method,
        count(*) 
	  from "Walmart_sales"
	  group by payment_method

--sales category(high/mediun/low)
select total,
          case
		  when total>=1000 then 'high sales'
		  when total>=500 then  'mediun sales'
		  else 'Low sales'
end as sales_category
from "Walmart_sales"

--quantity category using case
select quantity,
             Case
			 when quantity>=10 then 'Bulk Order'
			 Else 'Regular Order'
			 end as order_type
from "Walmart_sales"


--average rating by branch
select payment_method,
    avg(rating) as average_rating
	from "Walmart_sales"
	group by payment_method
	order by average_rating desc;
--
select 
    category,
	sum(total) as total_revenue,
	sum(total * profit_margin) as profit
	from "Walmart_sales"
	group by category

--most common payment method for each branch
--display branch and preffered_payment_method
select 
     branch,
	 payment_method,
	 count(*) as total_trans,
	 rank() over(partition by branch order by count(*) desc) as rnk
	 from "Walmart_sales"
	 group by branch,payment_method;