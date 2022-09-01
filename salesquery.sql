			
Use fortunedb			
											------------------Inspecting data--------------------
SELECT * 
FROM [dbo].[sales_data_sample]

										------------------Checking Unique Values--------------------
SELECT DISTINCT STATUS
FROM [dbo].[sales_data_sample]

SELECT DISTINCT year_id 
FROM sales_data_sample

SELECT DISTINCT MONTH_ID, YEAR_ID 
FROM sales_data_sample
WHERE YEAR_ID = 2004
ORDER BY MONTH_ID

SELECT DISTINCT PRODUCTLINE 
FROM sales_data_sample

SELECT DISTINCT COUNTRY
FROM sales_data_sample

SELECT DISTINCT DEALSIZE
FROM sales_data_sample

SELECT DISTINCT TERRITORY 
FROM sales_data_sample

--Analysis

SELECT PRODUCTLINE, SUM(sales) as Revenue
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY 2 desc

SELECT YEAR_ID, SUM(sales) as Revenue
FROM sales_data_sample
GROUP BY YEAR_ID
ORDER BY 2 desc

SELECT DEALSIZE, SUM(sales) as Revenue
FROM sales_data_sample
GROUP BY DEALSIZE
ORDER BY 2 desc

--WHAT WAS THE BEST MONTH FOR SALES IN A SPECIFIC YEAR

SELECT MONTH_ID, SUM(sales) as Revenue, COUNT(Ordernumber) as Frequency
FROM sales_data_sample
WHERE YEAR_ID = 2003
GROUP BY MONTH_ID
ORDER BY 2 desc

--WHAT PRODUCT IS BEEN SOLD IN NOVEMBER

SELECT MONTH_ID, Productline, SUM(sales) as Revenue, COUNT(Ordernumber) as Frequency
FROM sales_data_sample
WHERE YEAR_ID = 2003 and MONTH_ID = 11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY 3 desc

------------------------Finding our best customers
DROP TABLE IF EXISTS #rfm
;with rfm as
(
   SELECT CUSTOMERNAME, 
   SUM(sales) as Monetaryvalue, 
   AVG(sales) as AvgMonetaryvalue, 
   COUNT(Ordernumber) as Frequency, 
   MAX(orderdate) as Last_orderdate,
   (SELECT MAX(orderdate) FROM [dbo].[sales_data_sample]) as Max_orderdate,
   DATEDIFF(DD, MAX(orderdate), (SELECT MAX(orderdate) FROM [dbo].[sales_data_sample])) as Recency
   FROM sales_data_sample
   GROUP BY CUSTOMERNAME
),
rfm_calc as
(
	select r. *,
		NTILE(4) OVER (order by Recency desc) as rfm_recency,
		NTILE(4) OVER (order by Frequency) as rfm_frequency,
		NTILE(4) OVER (order by Monetaryvalue) as rfm_monetary
	from rfm r
)
	select c. *, rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell,
	cast(rfm_recency as varchar) + cast(rfm_frequency as varchar) + cast(rfm_monetary as varchar) as rfm_string
into #rfm
from rfm_calc c

Select CUSTOMERNAME, rfm_recency, rfm_frequency, rfm_monetary 
from #rfm

--------------Revenue by country

Select COUNTRY, SUM(sales) as revenue
from sales_data_sample
group by COUNTRY
order by 2 desc

--------------Dealsize by country

SELECT COUNTRY, COUNT(dealsize) as Total_Size, COUNT(CASE WHEN dealsize = 'small' THEN 1 END) AS small, 
    COUNT(CASE WHEN dealsize = 'medium' THEN 1 END) AS medium,
 COUNT(CASE WHEN dealsize = 'large' THEN 1 END) AS large
 from sales_data_sample 
group by COUNTRY
Order by Total_Size desc
