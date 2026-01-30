with top_paying_jobs as 
(select 
job_id,
salary_year_avg,
job_posted_date,
name as Company_name
from job_postings_fact jf
left join company_dim c on jf.company_id = c.company_id

where 
        job_title ='Data Engineer' and 
        salary_year_avg is not NULL and 
        job_location ='Anywhere'
order by salary_year_avg desc
limit 10 ) 

select tpj.*,
sd.skills as skill_name
from top_paying_jobs tpj
join skills_job_dim sjd on tpj.job_id=sjd.job_id
join skills_dim sd on sjd.skill_id=sd.skill_id
order by salary_year_avg desc