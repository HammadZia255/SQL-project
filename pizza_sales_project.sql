 --    Basic:
-- 1. Retrieve the total number of orders placed.
create view total_number_of_orders AS
select count(order_id) as total_order
from orders;

select * from total_number_of_orders;

-- 2. Calculate the total revenue generated from pizza sales.
create view Total_Revenue as
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

select * from Total_Revenue;

-- 3.Identify the highest-priced pizza.
create view highest_priced_pizza as
select pt.name, p.price
from pizzas p
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
order by price desc
limit 1;
select * from highest_priced_pizza;

-- 4.Identify the most common pizza size ordered.
create view common_pizza_size_ordered as 
select p.size , count(od.order_details_id) as order_count
from order_details od
join pizzas p on od.pizza_id = p.pizza_id
group by p.size
order by order_count desc
limit 1;
select * from common_pizza_size_ordered;

-- 5.List the top 5 most ordered pizza types along with their quantities.
Create view top_5_most_ordered_pizzas as
Select pt.name , sum(od.quantity) As Quantity
from pizza_types pt
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.name
order by Quantity desc limit 5;

select * from top_5_most_ordered_pizzas;

-- Intermediate:
-- 6.Join the necessary tables to find the total quantity of each pizza category ordered.
create view total_quantity_by_category as
select pt.category, sum(od.quantity)as total_orders
from pizza_types pt
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by  pt.category
order by total_orders desc;

select * from total_quantity_by_category;

-- 7.Determine the distribution of orders by hour of the day.
create view orders_by_hour as
select hour(order_time) as hours, count(order_id) as orders_count
from orders
group by hours
order by orders_count desc;

select * from orders_by_hour;

-- 8.Join relevant tables to find the category-wise distribution of pizzas.
create view categoryWise_pizzas as
select category, count(name) as name 
from pizza_types
group by category; 

select * from categoryWise_pizzas;

-- 9.Group the orders by date and calculate the average number of pizzas ordered per day.
create view Avg_orders_per_day as
select round(avg(quantity),0) as Avg_orders_per_day from
(Select o.order_date, sum(od.quantity) AS quantity
from orders o
join order_details od on o.order_id = od.order_id
group by o.order_date) as order_quantity;

select * from Avg_orders_per_day;

-- 10.Determine the top 3 most ordered pizza types based on revenue.
create view top_3_most_ordered_pizza_by_Revenue as
Select pt.name, sum(p.price * od.quantity) as revenue
from pizza_types pt
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.name 
order by revenue desc
limit 3;

select * from top_3_most_ordered_pizza_by_Revenue;

-- Advanced:
-- 1.Calculate the percentage contribution of each pizza type to total revenue.
create view percentage_contribution_pizza_by_revenue as
Select pt.category, concat(round(sum(od.quantity * p.price)/ (SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id)*100,2), '%') as revenue_percentage
from pizza_types pt
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.category
order by  revenue_percentage desc;

select * from  percentage_contribution_pizza_by_revenue;

 








