SELECT 
    job_title,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL

SELECT 
    job_title,
    company_id,
    job_location
FROM 
    february_jobs

UNION ALL

SELECT 
    job_title,
    company_id,
    job_location
FROM 
    march_jobs


-- Practice Problem 1
-- Get the corresponding skill and skill type for each job posting in q1
-- Includes those without any skills, too
-- Why? Look at the skills and the type for each job in the first quarter that has a salary >70,000

WITH job_skill_type As (
    SELECT 
        sj.job_id,
        sj.skill_id,
        s.skills,
        s.type
    FROM 
        skills_job_dim sj
    LEFT JOIN skills_dim s
        ON sj.skill_id = s.skill_id
)
    
SELECT 
    j.job_id,
    j.job_posted_date,
    j.salary_year_avg,
    jstype.skills,
    jstype.type
FROM job_postings_fact j
LEFT JOIN job_skill_type AS jstype
    ON j.job_id = jstype.job_id
WHERE
    EXTRACT(QUARTER FROM j.job_posted_date) = 1
    AND salary_year_avg > 70000
ORDER BY job_id;


