create table january_jobs as
(select * FROM job_postings_fact
where EXTRACT(MONTH from job_posted_date) = 1)
