select skills,count(sjd.skill_id) as demand_count

from job_postings_fact jpf
inner join skills_job_dim sjd on jpf.job_id=sjd.job_id
inner join skills_dim sd on sjd.skill_id=sd.skill_id
where jpf.job_title='Data Engineer'
group by skills
order by demand_count desc
limit 5;