-- print details of shipments(sales) Where amount are > 2,000 and boxes are < 100?

Select *
from sales 
where amount > 2000 and boxes < 100;

--How many Shipments (sales) each of the sales persons had in the month of january 2022?

select sum(s.Amount), p.salesperson
from sales as s
join people as p
on p.SPID = s.SPID
where year(s.saledate) = '2022'
group by p.Salesperson
order by s.Amount desc;

--Which product sales more boxes? milk bars or Eclairs?

select pr.product, count(s.Boxes), sum(s.Amount)
from sales as s 
join products as pr
on s.PID = pr.PID
where pr.product in ('milk bars', 'Eclairs')
group by pr.product;

--Which product sold more boxes in the first 7days of febuary 2022? milk or Eclairs?

select s.SaleDate, s.Boxes, s.Amount, pr.Product
from sales as s 
join products as pr
on s.PID = pr.PID
where pr.product in ('milk bars', 'Eclairs') and s.SaleDate between '2022-02-01' and '2022-02-07'
group by pr.product;

--Which shipment had under 100 customers and under 100 boxes? Did any of them occur on wednesday?
select Customers, Boxes, SaleDate
from sales
where Customers <= 100 and boxes <=100 and dayofweek(SaleDate) =4

--What are the names of salespersons who had at least one shipment (sales) in the fist 7days of january 2022?

select distinct(p.Salesperson), s.Amount, s.Boxes, s.SaleDate
from people as p
join sales as s
on p.SPID = s.SPID
where s.SaleDate between '2022-01-01' and '2022-01-07'
order by Boxes; 

--which sales person did not make any shipmemt in the first 7days of january 2022?

select distinct(p.Salesperson), s.Amount, s.Boxes, s.SaleDate
from people as p
join sales as s
on p.SPID = s.SPID
where s.SaleDate between '2022-01-01' and '2022-01-07'
order by Boxes
limit 1;

--How many times did we ship more than 1,000 boxes in each month?

select extract(year_month from SaleDate) as month, count(Boxes), SaleDate
from sales
where Boxes >1000 
group by month;

select * from Geo;
select * from products;
select * from sales;

-- did we ship at least one box of 'After Nines' to "New Zealand' on all the months?

select extract(year_month from s.SaleDate)as month, Geo, s.Boxes, s.Amount, p.product
from sales s 
join geo g
on s.GeoID = g.GeoID
join products p
on s.PID = p.PID
where p.Product = 'After Nines' and g.Geo = 'New Zealand'
order by Boxes;

--India or Australia? who buys more chocolate boxes on a monthly basis?

select extract(year_month from s.SaleDate)as month, s.Amount, g.Geo
from sales s
join geo g
on s.GeoID = g.GeoID
where g.Geo in ('India', 'Australia')
order by s.Amount desc
