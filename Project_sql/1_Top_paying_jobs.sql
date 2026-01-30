select 
job_id,job_title,
job_location,
job_schedule_type,
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
limit 10 