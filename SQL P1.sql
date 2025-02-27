SELECT * FROM retail_sales_p1.retail_sales;
select * from retail_sales;
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;


SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL 
    OR sale_time IS NULL
    OR customer_id IS NULL 
    OR gender IS NULL 
    OR age IS NULL 
    OR category IS NULL 
    OR quantity IS NULL 
    OR price_per_unit IS NULL 
    OR cogs IS NULL;
    
    
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
/* 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05*/  
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

/* 1.Write a SQL query to retrieve all columns for category is equal to'beauty'*/  

SELECT *
FROM retail_sales
WHERE category= 'Beauty';
/* 1.Write a SQL query to retrieve all columns for age is equal to 50*/  

select * from retail_sales
where age = 50;

/*Write a SQL query to calculate the total sales (total_sale) for each category.*/

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

/*Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.*/

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

/*Write a SQL query to find all transactions where the total_sale is greater than 1000.*/

SELECT * FROM retail_sales
WHERE total_sale > 1000;

 /*Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.*/

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

      
     
/*Write a SQL query to find the top 5 customers based on the highest total sales */
 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
 
 /*Write a SQL query to find the number of unique customers who purchased items from each category.*/
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;
 
 
/*Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)*/
 
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;