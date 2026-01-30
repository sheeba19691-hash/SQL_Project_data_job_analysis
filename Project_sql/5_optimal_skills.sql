with skills_demand as (
    select 
    sd.skill_id,
    sd.skills,count(sjd.job_id) as demand_count
    from job_postings_fact jpf
    inner join skills_job_dim sjd on jpf.job_id=sjd.job_id
    inner join skills_dim sd on sjd.skill_id=sd.skill_id
    where job_title_short='Data Analyst'
    and salary_year_avg is not NULL
    group by sd.skill_id
       ),

average_salary as ( 
    select skills_job_dim.skill_id,
    ROUND(AVG(salary_hour_avg),0) as avg_salary
    from job_postings_fact 
    inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
    where job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL
    group by skills_job_dim.skill_id
    
    limit 25)

select 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary.avg_salary
from
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
order by 
demand_count DESC,
avg_salary desc

----any joins should be more on primary / foreign key
----2 CTEs means no 2 with but comma


----rewriting the same query more consisely

select 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    ROUND(AVG(salary_hour_avg),0) as avg_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
    where job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL
group by skills_dim.skill_id
having
    count(skills_job_dim.job_id)>10
order by avg_salary desc,
demand_count desc
limit 25
