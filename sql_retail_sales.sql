create database sql_project;


# Data cleaning
select * from sql_project.retail_sales
where transactions_id is null;

select * from sql_project.retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or 
customer_id is null
or 
gender is null
or
age is null
or 
category is null
or
 quantity is null
or
price_per_unit is null
or 
cogs is null
or
total_sale is null;

-- Data Exploration
select count(*) as total_sales  from sql_project.retail_sales;

-- how many unique customers we have?
select count(customer_id) from sql_project.retail_sales;

-- how many unique category we have?
select distinct category from sql_project.retail_sales;

 # Data Analysis & Findings
#The following SQL queries were developed to answer specific business questions:

# 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

SELECT 
    *
FROM
    sql_project.retail_sales
WHERE
    sale_date = '2022-11-05';

#2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' 
#and the quantity sold is more than 4 in the month of Nov-2022**:

SELECT 
  *
FROM retail_sales
WHERE 
category = 'Clothing'
AND 
sale_date= '2022-11-10'
AND
quantity >= 4;
    
--  3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

SELECT 
    category, SUM(total_sale) AS revenue
FROM
    sql_project.retail_sales
GROUP BY category;

-- 4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

SELECT 
    ROUND(AVG(age), 2) AS average_age
FROM
    sql_project.retail_sales
WHERE
    category = 'Beauty';
    
-- 5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**

SELECT 
    *
FROM
    sql_project.retail_sales
WHERE
    total_sale > 1000;
    

-- 6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

SELECT 
    category, gender, COUNT(*) AS total_transactions
FROM
    sql_project.retail_sales
GROUP BY category , gender
ORDER BY 1;

-- 7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

SELECT 
    YEAR(sale_date),
    MONTH(sale_date),
    AVG(total_sale) AS avg_sale
FROM
    sql_project.retail_sales
GROUP BY YEAR(sale_date) , MONTH(sale_date)
ORDER BY 1 , 3 DESC;


-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:


SELECT 
    SUM(total_sale) AS total_sales, customer_id
FROM
    sql_project.retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;


-- 9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
SELECT 
    COUNT(DISTINCT customer_id) AS count_unique_cust, category
FROM
    sql_project.retail_sales
GROUP BY category;

-- 10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

select * from sql_project.retail_sales;


with hourly_sales
as 
(select * ,case 
when hour(sale_time) <12  then 'morning'
when hour(sale_time) between 12 and 17 then 'afternoon'
 else 'evening'
 end as shift from sql_project.retail_sales )
 select shift,count(*)  as total_sales from hourly_sales
 group by shift




    
    
