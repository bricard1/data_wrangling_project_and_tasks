
SP_RENAME 'bricard.demo.tri_age' , 'age', 'COLUMN'
SP_RENAME 'bricard.demo.gendercode' , 'Gender', 'COLUMN'
SP_RENAME 'bricard.demo.ContactID' , 'ID', 'COLUMN'
SP_RENAME 'bricard.demo.address1_stateorprovince' , 'State', 'COLUMN'
SP_RENAME 'bricard.demo.tri_imaginecareenrollmentemailsentdate' , 'EmailSentDate', 'COLUMN'
SP_RENAME 'bricard.demo.tri_enrollmentcompletedate' , 'Completedate', 'COLUMN'





SELECT TOP 10* FROM bricard.demo
left join
(select ID, datediff(day,EmailDateFormat, CompleteDateFormat) as DifferenceDays from
(select *, try_convert(varchar, EmailSentDate, 101) as 'EmailDateFormat', try_convert(varchar, Completedate, 101) as 'CompleteDateFormat' from bricard.demo) B
where EmailDateFormat is not NULL and EmailDateFormat <> 'NULL' and CompleteDateFormat is not NULL and CompleteDateFormat <> 'NULL')C
on bricard.demo.ID = C.ID
ORDER BY NEWID()

UPDATE bricard.demo
SET EnrollmentStatus = 'Complete'
WHERE tri_imaginecareenrollmentstatus=167410011

UPDATE bricard.demo
SET EnrollmentStatus = 'Email Sent'
WHERE tri_imaginecareenrollmentstatus=167410001

UPDATE bricard.demo
SET EnrollmentStatus = 'Non Responder'
WHERE tri_imaginecareenrollmentstatus=167410004

UPDATE bricard.demo
SET EnrollmentStatus = 'Facilitated Enrollment'
WHERE tri_imaginecareenrollmentstatus=167410005

UPDATE bricard.demo
SET EnrollmentStatus = 'Incomplete Enrollments'
WHERE tri_imaginecareenrollmentstatus=167410002


UPDATE bricard.demo
SET EnrollmentStatus = 'Opted Out'
WHERE tri_imaginecareenrollmentstatus=167410004

UPDATE bricard.demo
SET EnrollmentStatus = 'Unprocessed'
WHERE tri_imaginecareenrollmentstatus=167410000

UPDATE bricard.demo
SET EnrollmentStatus = 'Second email sent'
WHERE tri_imaginecareenrollmentstatus=167410006
ALTER TABLE  bricard.demo
ADD Sex nvarchar(12);

UPDATE bricard.demo
SET Sex = 'female'
WHERE gender is not NULL and gender <> 'NULL' and gender = 2

UPDATE bricard.demo
SET Sex = 'male'
WHERE gender is not NULL and gender <> 'NULL' and gender = 1


UPDATE bricard.demo
SET Sex = 'other'
WHERE tri_imaginecareenrollmentstatus=167410000


select * from bricard.demo
where gender is not NULL and gender <> 'NULL' and gender = 1 

UPDATE bricard.demo
SET Sex = 'Unknown'
where gender is NULL or gender = 'NULL' 

ALTER TABLE  bricard.demo
ADD AgeGroup nvarchar(7);

UPDATE bricard.demo
SET AgeGroup = '0-25'
where age <=25 

UPDATE bricard.demo
SET AgeGroup = '26-50'
where age >= 26 and age <= 50


UPDATE bricard.demo
SET AgeGroup = '51-75'
where age >= 51 and age <= 75

UPDATE bricard.demo
SET AgeGroup = '76-100'
where age >= 76 and age <= 100

UPDATE bricard.demo
SET AgeGroup = '101-125'
where age >= 101 and age <= 125

