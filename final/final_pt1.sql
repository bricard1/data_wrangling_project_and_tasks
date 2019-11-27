
--select * from qbs181.bricard.finalmergedcopy

--SELECT DATEDIFF(day,tri_enrollmentcompletedate,actualdate)
--FROM qbs181.bricard.finalmergedcopy

-- SystolicValue
-- Diastolicvalue

--Baseline
--select contactid, avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
--as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
--t2 on t1.contactid=t2.contactid and t1.days=t2.days) A group by contactid
-- 128/79
--select avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
--as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
--t2 on t1.contactid=t2.contactid where t1.days=t2.days) A
--12 week avg
select contactid, avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
t2 on t1.contactid=t2.contactid where t1.days>0 and t2.daysplus<t1.days) A group by contactid

--122 75
select avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
t2 on t1.contactid=t2.contactid where t1.days>t2.days and t2.daysplus<t1.days) A



--Baseline
--select contactid, avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
--as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
--t2 on t1.contactid=t2.contactid and t1.days=t2.days) A group by contactid
-- 128/79
--select avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
--as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
--t2 on t1.contactid=t2.contactid and t1.days=t2.days) A

-- Baseline: 1= 58, 0=83
-- Final: 1=12, 0=34
select  count(bps) as something from (select contactid, avg(convert(int, BPStatus)) as bps from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
t2 on t1.contactid=t2.contactid where t1.days=t2.days and t1.BPStatus != 'NULL') A group by contactid) B Where bps=0
--12 week avg
select contactid, avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
t2 on t1.contactid=t2.contactid where t1.days>t2.days and t2.daysplus<t1.days) A group by contactid

--122 75
select avg(SystolicValue), avg(Diastolicvalue) from (select t1.* from bricard.finalmergednew1 t1 inner join (select contactid, min(days)
as days, (min(days)+84) as daysplus from bricard.finalmergednew1 group by contactid) 
t2 on t1.contactid=t2.contactid where t1.days>0 and t2.daysplus<t1.days and t1.BPStatus != 'NULL') A
-- 1= 21 , 0 =52
