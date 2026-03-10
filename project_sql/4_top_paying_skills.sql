/*
Question: What are the top skills based on salary?
- Look at the avergae salary asssocaiated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Anaysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/


SELECT 
    s.skills,
    ROUND(AVG(j.salary_year_avg),0) AS avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    j.job_title_short = 'Data Analyst' AND
    j.salary_year_avg IS NOT NULL
GROUP BY s.skills
ORDER BY avg_salary DESC
LIMIT 25;

/*
High Demand for Big Data & ML Skills: 
    Top salaries are commanded by analysts skilled in big data technologies (PySpark, 
    Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, 
    NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.

Software Development & Deployment Proficiency: 
    Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates 
    a lucrative crossover between data analysis and engineering, with a premium on skills 
    that facilitate automation and efficient data pipeline management.

Cloud Computing Expertise: 
    Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) 
    underscores the growing importance of cloud-based analytics environments, suggesting 
    that cloud proficiency significantly boosts earning potential in data analytics.
*/