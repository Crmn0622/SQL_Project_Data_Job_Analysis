/*
Question: What are the most optimal skills to learn (aka high in demand ad high salary)
- Identify skills in high demand and associated with high average salary
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand)
    offering strategic insights for career development in data role
*/


WITH skills_demand AS (
    SELECT 
        s.skill_id,
        s.skills,
        COUNT(j.job_id) AS demand_count
    FROM job_postings_fact j
    INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = True
    GROUP BY
        s.skill_id
) , average_salary AS (
    SELECT 
        s.skill_id,
        ROUND(AVG(j.salary_year_avg),0) AS avg_salary
    FROM job_postings_fact j
    INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE 
        j.job_title_short = 'Data Analyst' 
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = True
    GROUP BY s.skill_id 
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id
ORDER BY 
    demand_count DESC,
    avg_salary DESC
LIMIT 25;