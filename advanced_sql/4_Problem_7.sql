/*
Find the count of the number of remote job postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skills
*/

WITH remote_job_skills AS (
    SELECT 
        s.skill_id,
        COUNT(*) AS skill_job_count
    FROM 
        skills_job_dim s
    INNER JOIN job_postings_fact j
        ON j.job_id = s.job_id
    WHERE
        j.job_work_from_home = TRUE AND
        j.job_title_short = 'Data Analyst'
    GROUP BY 
        s.skill_id 
)

SELECT 
    skills.skill_id,
    skills.skills,
    skill_job_count
FROM
    remote_job_skills r
LEFT JOIN skills_dim AS skills
    ON r.skill_id = skills.skill_id
ORDER BY    
    skill_job_count DESC
LIMIT 5
