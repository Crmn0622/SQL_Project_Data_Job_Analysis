/*
Find job postings from the first quarter that have salary greater than $70,000
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/
SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date :: DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quater1_job_postings
WHERE 
    quater1_job_postings.salary_year_avg > 70000 AND
    quater1_job_postings.job_title_short = 'Data Analyst'
ORDER BY 
    quater1_job_postings.salary_year_avg DESC