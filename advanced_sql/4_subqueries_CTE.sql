-- Subqueries
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) AS january_jobs;

-- CTE
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;

-- Subqueries
SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT      
        company_id
    FROM
        job_postings_fact
    WHERE 
        job_no_degree_mention = true
    ORDER BY 
        company_id
)

-- CTE
/* Find the companies that have the most job openings.
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name*/

-- My Answer
WITH job_opening AS (
    SELECT
        company_id,
        COUNT(company_id) AS jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY 
        jobs DESC
)

SELECT
    c.name, j.jobs
FROM    
    job_opening j
LEFT JOIN company_dim c
    ON j.company_id = c.company_id


-- Sample Answer
WITH company_job_count AS(
    SELECT
        company_id,
        COUNT(company_id) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY 
        company_id
)

SELECT 
    c.name AS company_name,
    j.total_jobs
FROM 
    company_job_count j
LEFT JOIN company_dim c
    ON j.company_id = c.company_id
ORDER BY 
    j.total_jobs DESC;


-- Practice Problem 1
WITH skill_job_count AS (
    SELECT 
        skill_id,
        COUNT(job_id) AS skill_total_job
    FROM
        skills_job_dim
    GROUP BY
        skill_id
)

SELECT 
    s.skills,
    sjc.skill_total_job
FROM 
    skill_job_count sjc
LEFT JOIN skills_dim s
    ON sjc.skill_id = s.skill_id
ORDER BY 
    skill_total_job DESC
LIMIT 5;


-- Practice Problem 2
SELECT *
FROM  job_postings_fact
ORDER BY company_id
LIMIT 25


WITH job_posting_count AS (
    SELECT 
        company_id, 
        COUNT(job_id) AS total_job_posting
    FROM 
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY 
        company_id
)

SELECT c.name, j.total_job_posting,
    CASE
        WHEN j.total_job_posting <10 THEN 'Small'
        WHEN j.total_job_posting <=50 THEN 'Medium'
        ELSE 'Large'
    END AS size
FROM 
    job_posting_count j
LEFT JOIN company_dim c
    ON j.company_id = c.company_id