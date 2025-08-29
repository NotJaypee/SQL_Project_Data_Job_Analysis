/*
    Question: What are the most-indemand skills for data analysts?
    -Identify the top 10 in-demand skills for a data analyst
    -Focus on all job postings
*/

SELECT 
    skills,
    COUNT(skills_to_job.job_id) AS demand_count
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job ON skills_to_job.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = skills_to_job.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst' AND
    job_postings.job_location = 'Anywhere'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10