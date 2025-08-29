# Introduction
📊 Step into the data job market! Centered on data analyst roles, this project uncovers 💰 the top-paying opportunities, 🔥 the most in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 Curious about the SQL queries? You’ll find them in the [sql_project_analysis folder](/sql_project_analysis/).
# Background
Motivated by the goal of making sense of the data analyst job market, this project was developed to uncover both the highest-paying roles and the most sought-after skills. By highlighting where demand and salary intersect, it aims to simplify the path for others seeking to identify the most valuable skills and land optimal opportunities in data analytics.

🔍 Curious about where to ind the datasets? You’ll find them in the [sql_load folder](/sql_load/)
### The questions I wanted to answer through my SQL queries were:
1. **What are the top-paying data analyst jobs?**
2. **What skills are required for these top-paying jobs?**
3. **What skills are most in demand for data analysts?**
4. **Which skills are associated with higher salaries?**
5. **What are the most optimal skills to learn?**
# Tools I Used
To dive deep into the data analyst job market, I leveraged a set of powerful tools that made analysis and insights possible:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Every query in this project was designed to uncover different perspectives of the data analyst job market. Here’s how I tackled each question:

### 1. Top Paying Data Analyst Jobs

To get a clearer picture of the best opportunities in the field, I started by looking at the highest-paying data analyst roles. By narrowing the search to remote positions with listed salaries, this query brings forward the top jobs that offer the most competitive pay.

```sql
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
        10;
```
A closer look at the top-paying remote data analyst roles reveals:

- **Strong Compensation Potential:** Earnings stretch from $181,000 up to $650,000, with several roles clustered in the high $180K–$200K range.

- **Range of Employers:** From tech-driven firms like Zoom and SmartAsset to specialized companies such as Mantys and Motional, opportunities span multiple sectors.

- **Role Progression:** Titles range from entry-level Data Analyst to Senior, Principal, and Director positions, showing how career advancement directly aligns with higher pay.

![Top Paying Roles](assets\chart_1.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts roles; ChatGPT generated this graph from my SQL query results*
### 2. Top Paying Jobs and Skills
Building on the search for top-paying roles, this query goes a step further by connecting those positions to the specific skills they require. By focusing on the 10 highest-paying remote data analyst jobs and joining them with their listed skill sets, it provides a clear picture of which abilities are most valuable in securing the best-paying opportunities in the field.
```sql
WITH top_paying_jobs AS(

    SELECT
            job_id,
            job_title,
            companies.name AS company_name,
            salary_year_avg,
            job_posted_date
        FROM
            job_postings_fact AS job_posting
        LEFT JOIN company_dim AS companies
            ON companies.company_id = job_posting.company_id
        WHERE
            job_title LIKE '%Data Analyst%' AND
            job_location = 'Anywhere' AND
            salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT
            10
)
SELECT 
    top_paying_jobs.*,
    skills.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim AS skills_to_job ON skills_to_job.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim AS skills ON skills.skill_id = skills_to_job.skill_id
ORDER BY
    salary_year_avg DESC
```
Here’s the breakdown of skills from the top-paying data analyst roles:

- **Most In-Demand Skills:** Tools like SQL, Python, R, Tableau, and Hadoop consistently appear across multiple roles, showing their broad importance in the job market.

- **Highest-Paying Skills:** Advanced technologies such as Python, Hadoop, Spark, and AWS are linked with the top salary ranges, reflecting strong demand for data engineering and analytics expertise.

- **Emerging Trends:** Skills tied to cloud platforms (AWS, Azure) and big data frameworks (Hadoop, Spark) stand out as especially lucrative, surpassing traditional BI-focused tools in earning potential.
![Top Paying Roles And Skills](assets\chart_2.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts roles and skills; ChatGPT generated this graph from my SQL query results*

### 3. Top Demand Skills
This query identifies the top 10 most in-demand skills for remote Data Analyst roles, showing which tools and technologies appear most often in job postings. These insights highlight the core skills employers value most in today’s data job market.

```sql
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
```
The top 10 most in-demand skills for Data Analysts highlight a clear mix of technical expertise and communication tools. These results reveal what employers prioritize most when hiring for remote roles.

- **Core Skills:** SQL, Excel, and Python dominate the list, proving essential for data manipulation and analysis.

- **Visualization Tools:** Tableau and Power BI are in high demand, reflecting the need to transform data into actionable insights.

- **Specialized & Supporting Skills:** R, SAS, Azure, and even PowerPoint emphasize versatility—balancing advanced analytics with effective presentation.

| Skills     | Demand Count |
|------------|--------------|
| SQL        | 7291         |
| Excel      | 4611         |
| Python     | 4330         |
| Tableau    | 3745         |
| Power BI   | 2609         |
| R          | 2142         |
| SAS        | 1866         |
| Looker     | 868          |
| Azure      | 821          |
| PowerPoint | 819          |

*Table of the demand for the top 10 skills in data analyst job postings*

### 4. Top Paying Skills
This query identifies the top 25 highest-paying skills for Data Analysts in remote positions. By calculating the average salary for each skill, it highlights which technical and analytical capabilities employers reward the most. The results provide valuable insights into which skills professionals should prioritize to maximize earning potential in remote data analyst roles.
```sql
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
LIMIT 20
```

The analysis of top-paying data skills highlights the technologies driving high salaries in data analytics and engineering roles.

- **Big data & cloud tools** like PySpark, Databricks, Airflow, and GCP dominate the list, reflecting their importance in handling large-scale data pipelines and cloud-based solutions.

- **Programming & data science libraries** such as Pandas, NumPy, Scikit-learn, and Jupyter remain crucial, showing strong demand for advanced analytics and machine learning expertise.

- **Collaboration & infrastructure tools** including Bitbucket, GitLab, Kubernetes, and Jenkins emphasize the value of DevOps integration and scalable data systems in modern workflows.

| Skill          | Avg. Salary (USD) |
|----------------|-------------------|
| PySpark        | 208,172           |
| Bitbucket      | 189,155           |
| Couchbase      | 160,515           |
| Watson         | 160,515           |
| DataRobot      | 155,486           |
| GitLab         | 154,500           |
| Swift          | 153,750           |
| Jupyter        | 152,777           |
| Pandas         | 151,821           |
| Elasticsearch  | 145,000           |
| GoLang         | 145,000           |
| NumPy          | 143,513           |
| Databricks     | 141,907           |
| Linux          | 136,508           |
| Kubernetes     | 132,500           |
| Atlassian      | 131,162           |
| Twilio         | 127,000           |
| Airflow        | 126,103           |
| Scikit-Learn   | 125,781           |
| Jenkins        | 125,436           |

*Table of the demand for the top 20 paying skills in data analyst job postings*

### 5 The Optimal Skills To Learn
This query identifies the most valuable remote Data Analyst skills by combining both salary potential and demand. It highlights skills that appear in multiple job postings (with at least 10 mentions) and ranks them based on average salary and demand, providing insight into which skills offer the best career opportunities.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 20;
```
- **High-paying specialized tools:** Niche technologies like Go ($115K), Confluence ($114K), and Hadoop ($113K) command the highest average salaries despite relatively lower demand, suggesting strong pay premiums for specialized expertise.

- **Cloud and data platforms dominate:** Skills such as Snowflake ($113K, 37 roles), Azure ($111K, 34 roles), and AWS ($108K, 32 roles) show both high demand and high salaries, highlighting the value of cloud-based data management in analyst roles.

- **Mainstream data tools sustain demand:** Widely adopted skills like Python (236 roles, $101K), R (148 roles, $100K), and Tableau (230 roles, $99K) remain consistently in-demand, offering strong opportunities for analysts seeking stable, versatile career paths.

| Skill ID | Skill       | Demand Count | Avg. Salary |
|----------|-------------|--------------|-------------|
| 8        | Go          | 27           | 115,320     |
| 234      | Confluence  | 11           | 114,210     |
| 97       | Hadoop      | 22           | 113,193     |
| 80       | Snowflake   | 37           | 112,948     |
| 74       | Azure       | 34           | 111,225     |
| 77       | BigQuery    | 13           | 109,654     |
| 76       | AWS         | 32           | 108,317     |
| 4        | Java        | 17           | 106,906     |
| 194      | SSIS        | 12           | 106,683     |
| 233      | Jira        | 20           | 104,918     |
| 79       | Oracle      | 37           | 104,534     |
| 185      | Looker      | 49           | 103,795     |
| 2        | NoSQL       | 13           | 101,414     |
| 1        | Python      | 236          | 101,397     |
| 5        | R           | 148          | 100,499     |
| 78       | Redshift    | 16           | 99,936      |
| 187      | Qlik        | 13           | 99,631      |
| 182      | Tableau     | 230          | 99,288      |
| 197      | SSRS        | 14           | 99,171      |
| 92       | Spark       | 13           | 99,077      |

*Table of the most optimal skills for data analyst sorted by salary*

# What I learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🔗 Mastering Joins & Relationships:** Learned how to seamlessly connect multiple tables (job_postings_fact, skills_job_dim, skills_dim, company_dim) to uncover hidden insights about roles, skills, and salaries.

- **⚡ CTE Power Moves:** Got hands-on with WITH clauses to build clean, reusable CTEs, stacking queries inside queries for advanced filtering, ranking, and structuring.

- **📊 Aggregation Mastery:** Sharpened my ability to use COUNT(), AVG(), and ROUND() with GROUP BY and HAVING, making it second nature to summarize demand and pay trends.

- **📌 Filtering for Precision:** Applied smart filters (WHERE, HAVING, LIMIT, ORDER BY) to zoom in on top-paying, most in-demand, and optimal skills without drowning in raw data.

- **🧠 Data-Driven Storytelling:** Translated raw query results into actionable insights — from spotting high-paying niche tools to identifying in-demand mainstream skills — turning SQL into a true decision-making engine.


# Conclusions

### Insights
From the analysis, several key insights about data analyst roles and skills became clear:

1. **Top-Paying Data Analyst Jobs**: Remote data analyst roles can reach salaries as high as $650,000, highlighting the earning potential for highly specialized positions.
2. **Skills for Top-Paying Jobs**: **SQL** consistently appears as the backbone skill for top-paying roles, proving its critical importance in handling complex data queries and analysis.
3. **Most In-Demand Skills**: Employers demand **SQL** more than any other skill, reinforcing its status as a non-negotiable requirement for aspiring data analysts.
4. **Skills with Higher Salaries**: Niche skills such as SVN and Solidity command higher salaries, showing that specialized expertise can significantly boost earning potential.
5. **Optimal Skills for Job Market Value**: **SQL** offers the best of both worlds—high demand and strong salary averages—making it the most optimal skill to prioritize for long-term career growth.

### Closing Thoughts

This project not only gave me valuable insights into the data analyst job market but also strengthened my SQL skills through practical application. I learned how to seamlessly connect multiple tables such as job_postings_fact, skills_job_dim, skills_dim, and company_dim, uncovering hidden relationships between roles, skills, and salaries. I also gained confidence in using CTEs with WITH clauses, allowing me to build clean, reusable queries and even stack them for more advanced filtering, ranking, and structuring. Along the way, I sharpened my aggregation skills, applying functions like COUNT(), AVG(), and ROUND() with GROUP BY and HAVING to summarize demand and salary trends effectively. Precision filtering became second nature as I used WHERE, HAVING, LIMIT, and ORDER BY to zoom in on top-paying, in-demand, and optimal skills. Most importantly, I discovered the power of data-driven storytelling — transforming raw SQL results into actionable insights, whether identifying niche high-paying tools or highlighting mainstream in-demand skills. 
Overall, this experience showed me how mastering SQL is not just about writing queries but about driving meaningful insights and making data a true decision-making engine.