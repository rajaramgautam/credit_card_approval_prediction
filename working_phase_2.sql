-- creating table credit
CREATE TABLE credit(
	credit_id serial primary key,
	id char(7),
	months_balance numeric(20,2),
	status char(1)
	);
-- selecting table credit;	
select * from credit;
-- droping credit table


select count(*) from credit;
-- creating table family
CREATE TABLE family(
	family_id serial primary key,
	children_count numeric,
	family_status varchar(25),
	family_members_count numeric
	);
	
-- selecting family
select * from family;

-- counting family table row count
select count(*) from family;

-- droping table
-- drop table family;

-- creating table for property
CREATE TABLE property(
	property_id serial primary key,
	has_car char(1),
	has_realty char(1)
	);
	
-- selecting property table
select * from property;

-- drop table
-- drop table property;

-- creating table for communication
CREATE TABLE communication(
	communication_id serial primary key,
	has_mobile integer,
	has_work_phone integer,
	has_phone integer,
	has_email integer
	);
	
-- selecting property table
select * from communication;

-- drop table
-- drop table communication;
	
-- creating main table
CREATE TABLE application (
    credit_id serial,
    family_id serial,
    property_id serial,
	communication_id serial,
    code_gender INTEGER,
	days_birth INTEGER,
	days_employed INTEGER,
	name_housing_type varchar(50),
	name_education_type varchar(50),
	occupation_type varchar(50),
	amt_income_total numeric,
	name_income_type varchar(50), 
    PRIMARY KEY (credit_id, family_id, property_id, communication_id),
	CONSTRAINT fk_credit FOREIGN KEY(credit_id) REFERENCES credit(credit_id),
	CONSTRAINT fk_family FOREIGN KEY(family_id) REFERENCES family(family_id),
	CONSTRAINT fk_property FOREIGN KEY(property_id) REFERENCES property(property_id),
	CONSTRAINT fk_communication FOREIGN KEY(communication_id) REFERENCES communication(communication_id)
	);

-- selecting table application
select * from application;
	
-- creating table application_new	
CREATE TABLE application_new (
	application_new_id serial primary key,
    id integer,
    code_gender char(1),
	FLAG_OWN_CAR char(1),	
	FLAG_OWN_REALTY char(1),
	CNT_CHILDREN numeric,
	AMT_INCOME_TOTAL numeric,	
	NAME_INCOME_TYPE varchar(50),
	NAME_EDUCATION_TYPE	varchar(50),
	NAME_FAMILY_STATUS varchar(25),	
	NAME_HOUSING_TYPE varchar(50),	
	DAYS_BIRTH INTEGER,
	DAYS_EMPLOYED INTEGER,	
	FLAG_MOBIL integer,
	FLAG_WORK_PHONE integer,	
	FLAG_PHONE	integer,
	FLAG_EMAIL integer, 
	OCCUPATION_TYPE	varchar(50),
	CNT_FAM_MEMBERS numeric 
	);

-- drop application_new table
-- drop table application_new;
	
-- selecting application table
select * from application_new;

-- grouping by id for application_new
select count(*) from application_new 
group by id
order by count(*) desc;

-- selecting various tables for checking
select * from application_new limit 10;
select * from credit limit 10;
select * from property;
select * from family limit 1;


-- JOIN of property and application_new
select property_id, application_new_id, ID,	CODE_GENDER, CNT_CHILDREN, AMT_INCOME_TOTAL, NAME_INCOME_TYPE,	
NAME_EDUCATION_TYPE, NAME_FAMILY_STATUS, NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED, FLAG_MOBIL, 
FLAG_WORK_PHONE, FLAG_PHONE, FLAG_EMAIL, OCCUPATION_TYPE, CNT_FAM_MEMBERS from application_new
join property on application_new.flag_own_car = property.has_car and
				 application_new.flag_own_realty = property.has_realty;

----- JOIN of property, application_new, and family
select property_id, family_id, communication_id, application_new_id, ID, CODE_GENDER, AMT_INCOME_TOTAL, NAME_INCOME_TYPE,	
NAME_EDUCATION_TYPE, NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED, FLAG_MOBIL, 
FLAG_WORK_PHONE, FLAG_PHONE, FLAG_EMAIL, OCCUPATION_TYPE from application_new
join property on application_new.flag_own_car = property.has_car and
				 application_new.flag_own_realty = property.has_realty
join family on application_new.cnt_children = family.children_count and
			   application_new.NAME_FAMILY_STATUS = family.family_status and
			   application_new.cnt_fam_members = family.family_members_count;

--- JOIN of property, application_new, family, and communication
select property_id, family_id, communication_id, application_new_id, ID, CODE_GENDER, AMT_INCOME_TOTAL, NAME_INCOME_TYPE,	
NAME_EDUCATION_TYPE, NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED, OCCUPATION_TYPE from application_new
join property on application_new.flag_own_car = property.has_car and
				 application_new.flag_own_realty = property.has_realty
join family on application_new.cnt_children = family.children_count and
			   application_new.NAME_FAMILY_STATUS = family.family_status and
			   application_new.cnt_fam_members = family.family_members_count
join communication on 
					application_new.FLAG_MOBIL = communication.has_mobile and
					application_new.FLAG_WORK_PHONE = communication.has_work_phone and
					application_new.FLAG_PHONE = communication.has_phone and
					application_new.FLAG_EMAIL = communication.has_email;

------JOIN of property, application_new, family, communication, and credit
select  application_new_id, credit.ID, property_id, family_id, communication_id, CODE_GENDER, AMT_INCOME_TOTAL, 
NAME_INCOME_TYPE,	NAME_EDUCATION_TYPE, NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED, OCCUPATION_TYPE, months_balance, status 
from application_new
join property on application_new.flag_own_car = property.has_car and
				 application_new.flag_own_realty = property.has_realty
join family on application_new.cnt_children = family.children_count and
			   application_new.NAME_FAMILY_STATUS = family.family_status and
			   application_new.cnt_fam_members = family.family_members_count
join communication on 
					application_new.FLAG_MOBIL = communication.has_mobile and
					application_new.FLAG_WORK_PHONE = communication.has_work_phone and
					application_new.FLAG_PHONE = communication.has_phone and
					application_new.FLAG_EMAIL = communication.has_email
join credit on
				application_new.id = credit.id;
				
				
------JOIN of property, application_new, family, communication, and credit with id from application_new
select  application_new_id, application_new.ID, property_id, family_id, communication_id, CODE_GENDER, AMT_INCOME_TOTAL, 
NAME_INCOME_TYPE,	NAME_EDUCATION_TYPE, NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED, OCCUPATION_TYPE, months_balance, status 
from application_new
join property on application_new.flag_own_car = property.has_car and
				 application_new.flag_own_realty = property.has_realty
join family on application_new.cnt_children = family.children_count and
			   application_new.NAME_FAMILY_STATUS = family.family_status and
			   application_new.cnt_fam_members = family.family_members_count
join communication on 
					application_new.FLAG_MOBIL = communication.has_mobile and
					application_new.FLAG_WORK_PHONE = communication.has_work_phone and
					application_new.FLAG_PHONE = communication.has_phone and
					application_new.FLAG_EMAIL = communication.has_email
join credit on
				application_new.id = credit.id;

------- Various select with limit = 1 to check datatypes in column					
select * from communication limit 1;
select * from credit limit 1;
select * from application_new limit 1;

-- Altering the data type of column
ALTER TABLE application_new
ALTER COLUMN id TYPE varchar;

-- Creating view for large sql for quick calling
create view application_final1 as 
select  application_new_id, credit.ID, property_id, family_id, communication_id, CODE_GENDER, AMT_INCOME_TOTAL, 
NAME_INCOME_TYPE,	NAME_EDUCATION_TYPE, NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED, OCCUPATION_TYPE, months_balance, status 
from application_new
join property on application_new.flag_own_car = property.has_car and
				 application_new.flag_own_realty = property.has_realty
join family on application_new.cnt_children = family.children_count and
			   application_new.NAME_FAMILY_STATUS = family.family_status and
			   application_new.cnt_fam_members = family.family_members_count
join communication on 
					application_new.FLAG_MOBIL = communication.has_mobile and
					application_new.FLAG_WORK_PHONE = communication.has_work_phone and
					application_new.FLAG_PHONE = communication.has_phone and
					application_new.FLAG_EMAIL = communication.has_email
join credit on
				application_new.id = credit.id;

-- Creating view for large sql query for quick calling with application_new.id
create view application_final3 as 
select  application_new_id, application_new.ID, property_id, family_id, communication_id, CODE_GENDER, AMT_INCOME_TOTAL, 
NAME_INCOME_TYPE,	NAME_EDUCATION_TYPE, NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED, OCCUPATION_TYPE, months_balance, status 
from application_new
join property on (application_new.flag_own_car = property.has_car and
				 application_new.flag_own_realty = property.has_realty)
join family on (application_new.cnt_children = family.children_count and
			   application_new.NAME_FAMILY_STATUS = family.family_status and
			   application_new.cnt_fam_members = family.family_members_count)
join communication on 
					(application_new.FLAG_MOBIL = communication.has_mobile and
					application_new.FLAG_WORK_PHONE = communication.has_work_phone and
					application_new.FLAG_PHONE = communication.has_phone and
					application_new.FLAG_EMAIL = communication.has_email)
join credit on
				(application_new.id = credit.id);
				
-- checking row counts of both views				
select count(*) from application_final1;
select count(*) from application_final2;

select * from application_final2 order by application_new_id, id, property_id, family_id, communication_id;

select * from application_final3 order by application_new_id;

select * from property;
select * from family;

select * from application_new;

select * from credit;

-- joining application_new and credit on id

select * from application_final1;

# Distinct status of credit 
select distinct status from credit; 
-- Since 0 balance on credit card is not good for credit card company, so CEO would like to know customer id 
-- whose average credit card balance is 0. So that we can tell marketing department to run promotional offer
-- for those customer to spend more from the credit cards.

create view average_monthly_balance_customer as 
select avg(months_balance) as average_monthly_balance from credit group by id;

select count(*) from average_monthly_balance_customer
where average_monthly_balance = 0;

select * from application_new;

-- Social scientist wants to convince people for going school, so he would like to see the difference in
-- income based on education type.

select avg(amt_income_total), name_education_type from application_new 
group by name_education_type order by avg(amt_income_total);



-- Difference in male and female pay
select avg(amt_income_total), code_gender from application_new 
group by code_gender order by avg(amt_income_total);

select * from application_new;

-- Housing type vs income
select avg(amt_income_total), name_housing_type from application_new 
group by name_housing_type order by avg(amt_income_total);

