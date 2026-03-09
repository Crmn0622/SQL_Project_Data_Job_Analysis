-- Practice Problem 6
-- January 
CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY'THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category;

-- Practice Problem 1
SELECT  MIN(salary_year_avg), AVG(salary_year_avg), MAX(salary_year_avg)
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_title_short;

-- High >= 200,000
-- Standard >= 85,000
-- Low < 85,000s

SELECT  
    job_id,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 200000 THEN 'High'
        WHEN salary_year_avg >= 85000 THEN 'Standard'
        ELSE 'Low'
    END AS salary_bucket
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC

