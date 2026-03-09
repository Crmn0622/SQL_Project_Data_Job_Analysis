SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 5;

SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE   
    job_title_short = 'Data Analyst'
GROUP BY 
    month
ORDER BY 
    job_posted_count DESC;


-- Practice Problem 1
SELECT
    COUNT(job_id),
    AVG(salary_year_avg),
    AVG(salary_hour_avg)
FROM 
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-21' 
GROUP BY
    job_schedule_type
LIMIT 20;

-- Practice Problem 2
SELECT
    COUNT(*),
    EXTRACT (MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM 
    job_postings_fact
WHERE 
    EXTRACT (YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = '2023'
GROUP BY
    month
ORDER BY 
    month;

-- Practice Problem 3
SELECT DISTINCT
    j.company_id,
    c.name AS company_name,
FROM 
    job_postings_fact j 
LEFT JOIN company_dim c
    ON j.company_id = c.company_id
WHERE
    job_health_insurance = TRUE 
    AND EXTRACT (YEAR FROM job_posted_date) = 2023 
    AND EXTRACT (QUARTER FROM job_posted_date) = 2
    
