/*
    Question: What are the top skills based on the salary?
    -Look at the average salary associated with each skill for Data Analyst positions
    -Focuses on roles with specified salaries, regardless of the location
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
    
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job ON skills_to_job.job_id = job_postings.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = skills_to_job.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst'AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
   avg_salary DESC
LIMIT 25

/*
🔑 Insights from the Data

Big Data & ML Pay the Most – Skills like PySpark, Databricks, pandas, scikit-learn, DataRobot dominate, showing demand for analysts who handle large datasets and apply machine learning.

DevOps & Cloud Skills Boost Salaries – Tools like Bitbucket, GitLab, Kubernetes, GCP pay high, proving that analysts who can work with cloud infrastructure and production pipelines are rare and valuable.

Programming Beyond SQL Matters – Skills in Swift, Go, Linux, PostgreSQL highlight that multi-language and systems knowledge pushes analysts into higher-paying, hybrid analyst–engineer roles.

[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_salary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skills": "gcp",
    "avg_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "121619"
  }
]
*/
