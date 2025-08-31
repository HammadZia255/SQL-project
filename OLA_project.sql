-- Retrive all successful bookings?
Select * from booking
where booking_status = 'Success';

-- Find the Average ride distance for each vehicle type?
Select vehicle_type, avg(ride_distance) as avg_distance
from booking
group by vehicle_type
order by avg_distance desc;

-- Get the total number of canceled ride by customer?
Select count(*) as canceled_by_customer
from booking
where booking_status = 'Canceled by Customer';

-- List the top 5 customers who booked the highest No of ride?
Select customer_id , count(booking_id) as total_count
from booking
group by customer_id 
order by total_count desc
limit 5;

-- Get the total number of canceled ride by driver and reson personal & Car related issue?
Select count(*) as ride_cancel_by_driver from booking
where ride_cancel_by_driver = "Personal & Car related issue";

-- Find the maximum and minimum driver rating for prime sedan booking?
Select vehicle_type, max(driver_rating) as max_driver_rating,
min(driver_rating) as min_driver_rating from booking 
where  vehicle_type = 'Prime Sedan';

-- Retrive all rides where payment was made by UPI:
select * from booking
where payment_method = 'UPI';

-- Find the average customer rating per vehicle_type:
select vehicle_type, round(avg(customer_rating),2) as avg_customer_rating
from booking
group by vehicle_type;

-- Calculate the total booking value of ride completely successfully:
Select sum(booking_value) as total_successful_ride_value
from booking 
where booking_status = 'Success';

Select * from booking;
-- List all incomplete ride along with the reason:
Select booking_id, incomplete_rides_reason 
from booking
where incomplete_rides = 'Yes';










