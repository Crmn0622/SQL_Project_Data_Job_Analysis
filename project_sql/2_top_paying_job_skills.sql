/*
Uestion: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific sskills required for these roles
- Why? It provides a detailed look at which hgih-paying jobs demand certian skills, 
helping job seekers understnad which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT     
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
    FROM 
        job_postings_fact j
    LEFT JOIN company_dim c
        ON j.company_id = c.company_id 
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    t.*,
    sd.skills 
FROM top_paying_jobs t
INNER JOIN skills_job_dim s ON  t.job_id = s.job_id
INNER JOIN skills_dim sd ON s.skill_id = sd.skill_id
ORDER BY 
    t.salary_year_avg DESC;

/*

Insight

SQL is leading with a bold count of 8.
Python folllows closely with a bold count of 7.
Tableau is also highly sought after, with a bold count of 6. 
Other skillls like R, Snowflake, Pandas, and Excel show varying degrees of demand, but SQL, Python, and Tableau are the clear frontrunners in the top-paying Data Analyst roles.


*/