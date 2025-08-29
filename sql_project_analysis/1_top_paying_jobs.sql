/*
  Question: What are the top paying data analyst jobs ?
  -Identify the top 10 highest-paying Data Analyst roles that are available remotely.
  -Focuses on job posting with specified salaries (remove nulls).
*/

WITH company_name AS(
    SELECT
        company_id,
        name
    FROM
        company_dim
)
SELECT
        job_id,
        job_title,
        job_location,
        companies.name AS company_name,
        job_schedule_type,
        salary_year_avg,
        job_posted_date
    FROM
        job_postings_fact AS job_posting
    INNER JOIN company_name AS companies
        ON companies.company_id = job_posting.company_id
    WHERE
        job_title LIKE '%Data Analyst%' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10