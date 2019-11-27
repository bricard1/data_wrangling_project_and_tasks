
--SELECT  
--tricontactid, SenderName, gendercode, tri_age,parentcustomeridname

select *from  (select * from TextMessages inner join (select * from dbo.Demographics
inner join Conditions on Demographics.contactid=Conditions.tri_patientid) A on tri_contactid= A.contactid) B
--select * from TextMessages

--select tri_contactid, tri_age,parentcustomeridname, min(DATEDIFF(day,'1900-01-01',TextSentDate)) from  (select * from TextMessages inner join (select * from dbo.Demographics
--inner join Conditions on Demographics.contactid=Conditions.tri_patientid) A on tri_contactid= A.contactid) B group by tri_contactId
--select * from TextMessages

select tri_contactid, min(DATEDIFF(day,'1900-01-01',TextSentDate)) as minimumdatefromjan1, tri_age, parentcustomeridname,tri_imaginecareenrollmentemailsentdate, address1_stateorprovince,tri_imaginecareenrollmentstatus, tri_enrollmentcompletedate,gendercode, tri_name  from  (select * from TextMessages inner join (select * from dbo.Demographics
inner join Conditions on Demographics.contactid=Conditions.tri_patientid) A on tri_contactid= A.contactid) B group by tri_contactId,  tri_age, parentcustomeridname,tri_imaginecareenrollmentemailsentdate, address1_stateorprovince,tri_imaginecareenrollmentstatus, tri_enrollmentcompletedate,gendercode, tri_name 
--select * from TextMessages
