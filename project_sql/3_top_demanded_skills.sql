/*
Question: What are the most in-demand skills for data analyst jobs?
- Join job postings to inner join table similar to query 2
- Identify the top-5 in-demand skills for Data Analyst roles.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/


SELECT 
    s.skills,
     COUNT(j.job_id) AS demand_count
FROM job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
GROUP BY
    s.skills
ORDER BY
    demand_count DESC
LIMIT 5;

