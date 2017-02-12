# copy original data to a new table
CREATE TABLE temp1 LIKE testdata;
INSERT temp1 
SELECT * FROM testdata;


#create new row for nodes and time_second
ALTER TABLE temp1 ADD (time_second int, node1 int, node2 int, node3 int);


#insert nodes form tower table
update temp1,tower
set 
temp1.node1 = tower.Node1,
temp1.node2 = tower.Node2,
temp1.node3 = tower.Node3
where (temp1.LAT = tower.LAT) and (temp1.LON = tower.LON);

update temp1 set time_second = 0;
update temp1 set time_second = (TIME_TO_SEC(CTIME));


#Delete unnecessary columns
alter table temp1
drop CTIME,
drop DURATION,
drop LAT,
drop LON;


# create and fill a table for raplacing UNIQ_ID with ID 
create table temp2(
	UNIQ_ID varchar(18)
	, ID int	not null primary key auto_increment unique  
);
insert into temp2(UNIQ_ID)
Select UNIQ_ID from temp1
group by UNIQ_ID;


#Update UNIQ_ID to ID
ALTER TABLE temp1 ADD ID int;

update temp1,temp2
set temp1.ID = temp2.ID
where temp1.UNIQ_ID = temp2.UNIQ_ID;

alter table temp1 drop UNIQ_ID;




/*
#Separate data which has only one node assigned
CREATE TABLE temp3 LIKE temp1;

INSERT into temp3 
SELECT * FROM temp1
where node2 = 0;

alter table temp3 
drop node2,
drop node3;

#Find the order of the one node data
CREATE TABLE temp4 LIKE temp3;
ALTER TABLE temp4 add count int;

insert into temp4
select * ,count(node1) from temp3 
group by node1
order by ID, count(node1) desc;

drop table temp3;


#separate the id wise rank data
create table temp5(
	ID int
	, node1 int not null 
	, count1 int not null  
	, node2 int not null 
	, count2 int not null 
	, node3 int not null 
	, count3 int not null  
);

insert into temp5(ID)
select ID from temp4
group by ID;
 
update temp4, temp5
set temp5.node1 = temp4.node1,temp5.count1 = temp4.count
where(temp5.ID = temp4.ID);

update temp4, temp5
set temp5.node1 = temp4.node1,temp5.count1 = temp4.count
where(temp5.ID = temp4.ID) and (temp4.count > temp5.count1);

update temp4, temp5
set temp5.node2 = temp4.node1,temp5.count2 = temp4.count
where(temp5.ID = temp4.ID) and (temp4.count < temp5.count1);

drop table temp4;

#Separate the data which has three nodes
CREATE TABLE temp6 LIKE temp1;
insert into temp6
Select * from temp1
where node3 > 0;

#replace with higher node frequency
update temp6, temp5
set  temp6.node1 = (case
when((temp6.node1 = temp5.node1) 
or (temp6.node2 = temp5.node1) 
or (temp6.node3 = temp5.node1))
then temp5.node1
when((temp6.node1 = temp5.node2) 
or(temp6.node2 = temp5.node2) 
or(temp6.node3 = temp5.node2))
then temp5.node2
when ((temp6.node1 = temp5.node3) 
or (temp6.node2 = temp5.node3)
or (temp6.node3 = temp5.node3))
then temp5.node3
end)
where (temp6.ID = temp5.ID );


#Separate the data which has two nodes
CREATE TABLE temp7 LIKE temp1;
insert into temp7
Select * from temp1
where node3 = 0 and node2 > 0;
alter table temp3 
drop node3;

#replace with higher node frequency
update temp7, temp5
set  temp7.node1 = (case
when((temp7.node1 = temp5.node1) 
or (temp7.node2 = temp5.node1))
then temp5.node1
when((temp7.node1 = temp5.node2) 
or(temp7.node2 = temp5.node2))
then temp5.node2
when ((temp7.node1 = temp5.node3) 
or (temp7.node2 = temp5.node3))
then temp5.node3
end)
where (temp7.ID = temp5.ID );

drop table temp5;

#update the main data
update temp1, temp6
set temp1.node1 = temp6.node1
where temp1.ID = temp6.ID and temp1.time_second = temp6.time_second;

update temp1, temp7
set temp1.node1 = temp7.node1
where temp1.ID = temp7.ID and temp1.time_second = temp7.time_second;

alter table temp1 
drop node2,
drop node3;

drop table temp6;
drop table temp7;


#order the data
#CREATE TABLE temp7 LIKE temp1;


#insert into temp7
#select * from temp1
#group by node1, ID
#order by ID, time_second;

*/













