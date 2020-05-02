-- what is dermstore's busiest day of the week?
select case weekday(o.date_created)
         when 0 then 'Monday'
         when 1 then 'Tuesday'
         when 2 then 'Wednesday'
         when 3 then 'Thursday'
         when 4 then 'Friday'
         when 5 then 'Saturday'
         when 6 then 'Sunday'
       end as weekday,
       sum((p.product_price - p.product_cost) * i.item_quantity) profit,
	   sum(p.product_price * i.item_quantity) as revenue,
       count(distinct o.order_id) as order_count
from dermstore.orders o
left join dermstore.orders_items i on o.order_id = i.order_id
left join dermstore.products p on i.product_id = p.product_id
group by o.date_created
order by order_count desc;



-- what products have the most repeat customers
with cte as (
	select c.customer_id,
	       i.product_id,
	       count(distinct extract(day from o.date_created)) repeat_purchases
	from dermstore.orders_items i
	left join dermstore.orders o on i.order_id = o.order_id
	left join dermstore.customers c on o.customer_id = c.customer_id
	group by c.customer_id, i.product_id
	having repeat_purchases > 1
)
select product_id,
	   count(repeat_purchases) repeat_customers
from cte
group by product_id
order by repeat_customers desc;



-- possible duplicate orders within the last 24 hours
with cte as (
select order_id,
       customer_id,
       row_number () over (partition by customer_id, order_total order by date_created) as row_num
from dermstore.orders
where date_created >= now() - INTERVAL 1 DAY)
select * from cte where row_num > 1;
