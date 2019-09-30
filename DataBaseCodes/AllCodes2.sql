SHOW FULL PROCESSLIST;

INSERT INTO july18a
SELECT LAT, COUNT(*)
	, LON
FROM july18
GROUP BY LAT
ORDER BY COUNT(*) desc;

create table july18a(
	Lat float
	, count int	
	, LON float
);
select count(*) from Master_Table

truncate table temp15; 
drop table temp10;

select * from july18 order by time_second desc

INSERT INTO july18b 
SELECT UNIQ_ID, COUNT(*)
FROM july18
group by UNIQ_ID
HAVING COUNT(*) > 1;

CREATE TABLE july18b LIKE Test; 

CREATE TABLE july18 LIKE Test; 
INSERT july18 SELECT * FROM Test;


delete from july18
where UNIQ_ID=(select UNIQ_ID, count(*)
from july18
HAVING COUNT(*) = 1)

SELECT MAX(DURATION) FROM july18


select time ('15:45:43')

ALTER TABLE july18 ADD time_second int;

update july18 set time_second = 0;

update july18 set time_second = (TIME_TO_SEC(CTIME));

describe july18

SELECT UNIQ_ID, LAT, COUNT(*) FROM july18 GROUP BY UNIQ_ID, LAT having count(*)=1;

LOAD DATA INFILE 'C:/GP.txt' INTO TABLE tower

select * from tower  where LAT like 23.5394;
update fulldata set fulldata.node = tower.node where fulldata.LAT like tower.LAT;

LOAD DATA LOCAL INFILE 'D:\\temp\\Tower.csv' 
INTO TABLE tower 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r'

update Test,tower
set Test.node1 = tower.node1
where (Test.LAT = tower.LAT) and (Test.LON = tower.LON)

CREATE TABLE june30_c LIKE june30;

INSERT june30_c
SELECT UNIQ_ID,CDATE,time_second,node1,node2,node3 FROM june30
order by UNIQ_ID, time_second ASC;

drop table june30;

INSERT Master_Table_c
SELECT DISTINCT UNIQ_ID, CDATE, CTIME, DURATION, LAT, LON FROM Master_Table;
