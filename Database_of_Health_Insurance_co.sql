/*Drop table statements*/

drop table message;
drop table claim_line;
drop table claims;
drop table premium;
drop table policy_dependent;
drop table policy;
drop table coveragee;
drop table health_insurance_plans;
drop table services;
drop table service_provider;
drop table dependent;
drop table  customer;
drop table user_info;

/*create statements*/
CREATE TABLE user_info
(
user_id int PRIMARY KEY,
user_type varchar(255) NOT NULL,
user_email_id varchar (255) NOT NULL,
user_password varchar (255) NOT NULL,
user_name varchar(255) NOT NULL,
user_mailing_address varchar(255) NOT NULL,
user_phone  integer NOT NULL
)

CREATE TABLE customer
(
cust_id integer PRIMARY KEY,
cust_dob date NOT NULL,
cust_gender varchar(10) NOT NULL,
Foreign key(cust_id) references user_info(user_id));
Create table dependent
(
dep_id integer Primary key,
cust_id integer,
dep_dob Date Not Null,
dep_gender Varchar(10) Not Null,
dep_relationship varchar(20) Not Null,
Foreign key(dep_id) references user_info(user_id),
Foreign key(cust_id) references customer(cust_id));

CREATE TABLE service_provider
(
sp_id INT PRIMARY KEY,
sp_type varchar (255) NOT NULL,
foreign key(sp_id) references user_info(user_id));

CREATE TABLE services
(
ser_id  INT PRIMARY KEY,
ser_description varchar (255) NOT NULL);

create table health_insurance_plans
(
plan_id int primary key,
cov_id int,
plan_year date,           	
plan_name varchar(50),        	
plan_amount_deductable number,           	
plan_max_outofpocket_member number,
plan_max_outofpocket_family number);

create table coveragee
(
cov_id int primary key,
plan_id int,
ser_id int,
cov_no_of_services_allowed int,
cov_allowed_charge number,
cov_in_network_copay number,
cov_in_network_coin number,
cov_out_network_copay number,
cov_out_network_coin number,
services_used number,
foreign key(ser_id) references services(ser_id),
Foreign key (plan_id) references health_insurance_plans (plan_id));

create table policy(
policy_id int primary key,
p_level int,
plan_id int,
cust_id int,
deductable_paid number,
premium_paid number,
foreign key (plan_id)references health_insurance_plans(plan_id),
foreign key (cust_id) references customer(cust_id));

create table policy_dependent(
policy_id int ,
dep_id int,
foreign key (policy_id)references policy (policy_id),
foreign key (dep_id) references dependent(dep_id));

CREATE TABLE premium
(
prem_id int primary key,
policy_id int,
prem_annual_rates NUMBER,
FOREIGN KEY (policy_id) REFERENCES policy (policy_id));

Create table claims
(
claim_id integer Primary key,
total_charge_cust number,
total_charge_ins number,
user_id integer,
sp_id integer,
policy_id int,
ser_date date,
foreign key(sp_id) references service_provider(sp_id),
foreign key(policy_id) references policy(policy_id),
foreign key(user_id) references user_info(user_id)
);

Create table claim_line
(
Claim_id number,
Service_id number,
status varchar(255),
Provider_charge number,
Amount_of_copay number,
Amount_of_ded number,
Amount_of_coins number,
Amount_paid_cust number,
Amount_paid_ins number,
Max_out_pocket_paid number,
Max_out_pocket_paid_family number,
foreign key(claim_id) references claims(claim_id),
foreign key(service_id) references services(ser_id),
Primary key(claim_id, Service_id));

create table message
(
message_id int primary key,
user_id int,
message_body varchar(255),
message_date date,
foreighn key(user_id) refernces user_info(user_id));

/* Insert Statements */
Insert: user_info
Insert statements for User_info, Customer, Dependent, Service_provider are Auto-populated by feature 1.
Insert: claim_line & claim
Insert statements for claim_line and claim will be auto-populated by feature 9
Insert: message
Insert statement for messages will be autopouplated with features like 1, 5, 6, 9,

/*Insert: service_provider */

Insert into SERVICE_PROVIDER values (73,'Innetwork');
Insert into SERVICE_PROVIDER values (69,'Innetwork');


/*Insert: services*/

Insert into SERVICES values (1,'X-Ray Scan');
Insert into SERVICES values (2,'Hospitalization');
Insert into SERVICES values (3,'Organ Transplant');
Insert into SERVICES values (4,'Surgery');
Insert into SERVICES values (5,'Eye checkup');


/*Insert: health_insurance_plans*/

Insert into HEALTH_INSURANCE_PLANS values (2,8,date '2017-09-01','PPO',100,30,30);
Insert into HEALTH_INSURANCE_PLANS values (3,5, date'2017-01-01', 'Aetna',400,200,350);
Insert into HEALTH_INSURANCE_PLANS values (4,10,date'2016-09-01', 'EPO',500,1000,2000);
Insert into HEALTH_INSURANCE_PLANS values (1,7,date'2016-09-01', 'PMO',78,3,4);


/*Insert: coveragee*/

Insert into COVERAGEE values (10,4,4,20,30,20,15,40,40,7);
Insert into COVERAGEE values (8,2,2,50,30,10,15,30,30,0);
Insert into COVERAGEE values (5,1,1,100,40,10,25,25,25,0);
Insert into COVERAGEE values (7,3,3,150,45,15,20,20,20,0);
Insert into COVERAGEE values (1,2,5,60,45,25,30,30,30,0);
Insert into COVERAGEE values (6,4,1,100,30,15,15,20,25,0);
Insert into COVERAGEE values (3,2,4,80,55,35,35,40,40,0);


/*Insert: policy*/

Insert into POLICY values (200,4,4,63,100,4000);
Insert into POLICY values (5,3,2,99,200,6000);
Insert into POLICY values (324,3,2,99,200,0);
Insert into POLICY values (3,3,2,99,200,3600);
Insert into POLICY values (1,2,1,63,200,3000);
Insert into POLICY values (22,3,2,99,200,0);


/*Insert: policy_dependent*/

Insert into POLICY_DEPENDENT values (5,103);
Insert into POLICY_DEPENDENT values (324,103);
Insert into POLICY_DEPENDENT values (22,103);


/*Insert: premium*/

Insert into PREMIUM values (1,200,1000);
Insert into PREMIUM values (2,1,1500);
Insert into PREMIUM values (3,3,1200);
Insert into PREMIUM values (4,5,2000);
Insert into PREMIUM values (5,324,1500);


/*1.	Allow a user to register with the system. The user needs to provide user type (customer, dependent, or provider), name, address, phone#, email, password. For customer, please also provide birthdate and gender. For dependent, please also provide birthdate, gender, ID of the customer associated with the dependent, and relationship to the customer. For provider, the input also includes provider type (in-network or out-of-network). The procedure should check whether the email already exists in user table. If so, please print a message saying the user exists. Otherwise create a user with input values and return a new user ID. */
 
create or replace PROCEDURE register_user(
    usertype IN VARCHAR,
    email_id IN VARCHAR,
    password IN VARCHAR, 
    name IN VARCHAR,
    address IN VARCHAR, 
    phone IN number,
    dob IN date,
    gender IN varchar,
    custid IN number,
    depdob IN date,
    depgen IN varchar,
    deprel in varchar,
    sptype in varchar
    
  ) IS
cnt number;  
l_is_matching_row int;  
BEGIN /* loads the count in the variable */
cnt:=seq_user.nextval;
select count (*)
    into   l_is_matching_row
    from   user_info
    where  user_email_id = email_id;
    
if (l_is_matching_row=0)then  -- test the condition if there is no existing user 
  if (usertype='customer')then
  INSERT INTO user_info VALUES(cnt,usertype,email_id,password,name,address,phone);
  INSERT INTO customer VALUES(cnt,dob,gender);
  dbms_output.put_line('Customer created with userid: '||cnt);
  elsif (usertype='dependent')then
  INSERT INTO user_info VALUES(cnt,usertype,email_id,password,name,address,phone);
  INSERT INTO dependent VALUES(cnt,custid,depdob,depgen,deprel);
  dbms_output.put_line('Dependent created with userid: '||cnt);
  elsif(usertype='serviceprovider')then
  INSERT INTO user_info VALUES(cnt,usertype,email_id,password,name,address,phone);
  INSERT INTO service_provider VALUES(cnt,sptype);
  dbms_output.put_line('Service Provider created with userid: '||cnt);
  else
  dbms_output.put_line('Invalid Input!!');
  end if;
  
else
dbms_output.put_line('Value already Exists!!');
end if;
end;
/*Test Case for Customer, Dependent and Service Provider:*/
exec register_user('customer','anna@gmail.com','anna','abcde','swapnashilp',240-254-4150,date'2000-02-28','female',NULL,NULL,NULL,NULL,NULL)

exec register_user('dependent','ram@gmail.com','ram','prabhu','belwood grn',240-254-4220,NULL,NULL,110,date'1990-11-27','male','sibling',NULL)

exec register_user('serviceprovider','sham@gmail.com','shamsp','sham','grenville grn',240-254-5000,NULL,NULL,NULL,NULL,NULL,NULL,'in-network')



/*2.	Allow a user to login by providing email and password. Please check whether email exists and password matches. If not, please print a message to indicate the error. Otherwise print a message to indicate user has logged on. The procedure should return a value 1 for success login and 0 for unsuccessful log in.*/

Create or replace function return_values(emailid in varchar2,password in varchar2)   /* Function to return values*/
return number
IS
pass varchar(10);
BEGIN
	select user_password into pass from user_info where user_email_id = emailid;
	if pass=password then                                                                /*if else condition to check password */
  return 1;
  else
  return 0;
  end if;
exception
	when no_data_found then
	dbms_output.put_line('Invalid username and password!!');         /*exception handling*/
	return 0;
End;
/*Function Ends*/

Create or replace procedure login_users(emailid in VARCHAR2, password in VARCHAR2) IS                      /* procedure to login a user*/
value number;
Begin
	value := return_values(emailid,password);                /*function return values called */
	if value=1 then
		dbms_output.put_line('Successful Login!!');              /* condition to check if user was able to login successfully or unsuccessful*/
			else	
		dbms_output.put_line('Login Unsuccesful!!!');	
	end if;
End;



/*3.	Allow a user to read messages providing user id and a starting date. Print out messages for that user since that date.*/

create or replace PROCEDURE read_messages (userid in int, user_date in date) IS             
 /* procedure to read messages*/    
cursor c1 is select message_body from message where user_id=userid and message_date>=user_date and user_date<sysdate;        /*Defining cursor*/
messages message.message_body%type;                   /*Cursor to get the message body depending on condition provided*/
/*declaration of variable*/ 
u1 integer;
BEGIN
select count(*) into u1 from user_info where USER_ID=userid;   /*exception handling*/

if u1=0 then 
dbms_output.put_line('Invalid userid!');        /*If else condition check*/

elsif user_date>sysdate then
dbms_output.put_line('Invalid Date');

else
open c1;                         /*open cursor */
loop
fetch c1 into messages;             /*fetching cursor c1 into messages*/
exit when c1%notfound;
dbms_output.put_line(messages);
end loop;
close c1;                         /*close cursor */
end if;
exception
when no_data_found then
dbms_output.put_line('No such record exists!');
end;
 /*Procedure Ends*/
 
/*4.	Allow the system (not user) to add a policy for a customer and his or her dependents for a given year on a given health plan. Insert a message to message table saying that the customer has been enrolled into the policy with new policy ID.*/

create or replace function find_planid (planname in varchar) 
return number
IS
planid number;  /* this is a function to retrieve plan id*/
BEGIN
	select plan_id into planid from health_insurance_plans where plan_name = planname;
	return planid;
  End;
  
  /* Procedure for feature 4*/
  create or replace PROCEDURE Add_policy(
    customer_id IN VARCHAR,
  dependent_id IN VARCHAR,
   planyear IN date,
   planname IN varchar,
   Level_number IN number,
   deductablepaid in number,
   premiumpaid in number
  ) IS
 planid number;
 U1 number;
 u2 number;
 seq number;
begin
seq:=seq_policy_id3.nextval;
planid:=find_planid(planname);
select count(*) into u1 from customer where cust_id=customer_id;
select count(*) into u2 from dependent where dep_id=dependent_id;
if u1=0 or u2=0 
then 
dbms_output.put_line('Invalid customer! OR dependent');

ELSE

INSERT INTO policy VALUES(seq,Level_number,planid,customer_id,deductablepaid,premiumpaid);
INSERT INTO policy_dependent VALUES(seq,dependent_id);
INSERT INTO message VALUES(seq_message.nextval,customer_id, customer_id ||' has been enrolled into the policy with new policy ID'||seq,sysdate);
end if;
exception
when no_data_found then
dbms_output.put_line('No such record exists!');
End;


/* 5. Allow a user to add a dependent to a policy. The input includes dependent ID and policy ID.  The program needs to check whether the dependent is already on the policy. If so no change is needed. Otherwise insert a message to message table saying that the dependent has been added to the policy.*/

Ans.)
create or replace procedure add_dependent(
pol_id in number,
depdt_id in number
)
IS 
x int; 		-- declaring a variable
begin
select count(*) into x from policy_dependent where dep_id = depdt_id;  
-- loading the count in variable 
if (x=0) then insert into policy_dependent values (pol_id,depdt_id); 
-- if the dependent does not exist the variable matches to zero and values are inserted 
insert into message values (seq_message.nextval,depdt_id,depdt_id ||' is enrolled into policy',sysdate);
else 
dbms_output.put_line('Dependent Already Exits'); --exception if dependents already exist
end if;
end;

/*6. Allow a user to remove a dependent from a policy. The input includes dependent name and policy ID. Please check if the dependent is on the policy or not. If yes, remove the dependent and insert a message into the message table saying dependent removed.*/
 
create or replace procedure remove_dependent(
pol_id in number,
dep_name in varchar
)
IS 
x int;
begin
select count(*) into x from user_info where user_name = dep_name;
if (x!=0) then delete from policy_dependent where dep_id=(select user_id from user_info where user_type= 'dependent' and user_name = dep_name);
/*this conditions check for the existing dependent and delets the record if the dependent exits */
insert into message values (seq_message.nextval,(select user_id from user_info where user_type= 'dependent' and user_name = dep_name) ,(select user_id from user_info where user_type= 'dependent' and user_name = dep_name) ||' is removed from policy',sysdate);
/* Accordingly at the same time a messeage is inserted into the Message table is the dependent is removed */ 
else 
dbms_output.put_line('Dependent Does Not Exits');
end if;
end;
/*7. The system computes premium for a given policy. Please refer to Assumption 7 on how to compute the premium.*/

create or replace procedure premium_cal ( pol_id in number)                     /* Procedure to calculate premium*/
is
/*declaration of variable*/
total_premium number;
pl number;
pr number;
cnt number;
begin
select p_level into pl from policy where policy_id=pol_id;   
select count(*) into cnt from policy where policy_id=pol_id;  /*exception handling*/  
select prem_annual_rates into pr from premium where policy_id=pol_id;

if(cnt=0)then
dbms_output.put_line('Invalid policyid!!');            /* if else condition to check  for invalid policy ID and to calulate premium */
else
total_premium:=pl * pr;  /* calculation method*/
update policy set premium_paid=total_premium where policy_id=pol_id;  /* update policy table*/
end if;

exception
when no_data_found then
dbms_output.put_line('No Data Found!!');        /*exception handling*/ 
end; 
/*8. Allow a customer to look up a coverage for the policy held by the customer. The input includes policy ID, a substring of the service description. Please print out information listed in Assumption 5 if the coverage is in the policy. If the coverage is not in the policy, please print out the service is not covered in the policy.*/ 

create or replace procedure lookupcoverage(
pol_id in number,
cover in varchar -- can be a string or varchar
)IS
cid number;
sid number;
cnosa number ;
cvc number;
cinc number;
cinco number;
conc number;
conco number;
total varchar(20);
str varchar(20):='%'; 
str1 varchar(20); 
str2 varchar(20):='%'; 

begin
str1:=cover;
total:=str||str1||str2;
select c.cov_id,c.ser_id,c.COV_NO_OF_SERVICES_ALLOWED,c.COV_ALLOWED_CHARGE,c.COV_IN_NETWORK_COIN,c.COV_IN_NETWORK_COPAY,c.COV_OUT_NETWORK_COIN,c.COV_OUT_NETWORK_COPAY
 into cid,sid,cnosa,cvc,cinc,cinco,conc,conco from services s ,policy p,coveragee c,HEALTH_INSURANCE_PLANS hp where p.PLAN_ID=hp.PLAN_ID and p.POLICY_ID=pol_id and s.SER_DESCRIPTION like total and c.SER_ID=s.SER_ID;
dbms_output.put_line ('ClaimId is ' ||cid||' Service ID is '||sid||' Maximum service allowed'||cnosa||' Allowed Charge is ' ||cvc||' In network copay is '||cinc||' In network Coins is '||cinco||' Out of network copay is '||conc||' Out of network Coins is '||conco) ;

end;

exec LOOKUPCOVERAGE(200,'S'); 

/*9. [This is a complicate featzure and the amount of work can be counted as 3-4 other features] Allow a service provider to submit a claim. The service provider needs to enter provider ID, policy ID, name of patient, and service date. For each line of the claim, the provider needs to enter the service ID, amount charged by the provider. This feature will then do the following steps for each line: 
1) whether the provider and policy exist and whether the patient is under the policy and the service date is within the plan year, if not, the claim will be denied and a message should be inserted into message table stating the reason; 
2) whether the service is covered under the policy (including not exceeding the maximal number of services per year), if not, the service is denied (the rest of claim may still go through) and a message should be inserted into message table stating the reason.  
3) whether another claim containing the same service for the same customer on the same date by the same provider has been accepted, if so, this is a duplicate filing and the service should be rejected and a message should be inserted into message table stating the reason; 
4) adjust the charge, which should be the smaller of allowed charge and service provider’s charge; 
5) if the policy’s deductible is not reached, the patient is responsible for the smaller of the adjusted charge and remaining deductible (deductible limit – deductible paid so far by the policy holder), otherwise the deductible amount is set to zero;
6) if there is still charge left, charge to the patient the minimal of (the co-pay amount, the remaining charge, the remaining out-of-pocket charge for this member, the remaining out-of-pocket charge per family); E.g., if the co-pay is $50, the remaining charge is $100, the maximal out-of-pocket for this member is $1000 but the member has paid $900 (so remaining out-of-pocket charge for this member is $1000-$900=$100), and maximal out-of-pocket for family is $2000 but the family has paid $1990 (so remaining out-of-pocket charge for this family = $2000-$1990=$10), then the patient should pay $10. 
7) if there is still charge left, charge to the patient the minimal of (the co-insurance amount computed as remaining charge * co-insurance rate, the remaining out-of-pocket charge for this member, the remaining out-of-pocket charge per family). In the above example, since the remaining out-of-pocket charge per family is $0 now, there is no additional charge to patient. 
8) The insurance company will be charged the remaining charge and a message should be inserted into message table stating the service ID and service description, provider’s charge, allowed charge, amount of co-pay, amount of deductible (if customer has not reach deductible yet), amount of co-insurance, amount paid by insurance, amount paid by customer.*/ 

Create or replace procedure submit_claim(spid in number,pol_id in number,pat_name in varchar,s_date in date,service in number,charge in number) IS
value number;
uid number;
totalcharge number;
p_charge number;
chargetobepaid_n number;
remaining number;
chargetobepaid number;
servicecovered number;
alreadyexists number;
clmid number;
allowed_charge number;
amt_ded number;
amt_ded_paid number;
sum_claim number;
sum_claim_ins number;
Begin
select user_id into UID from user_info where USER_NAME=pat_name;
clmid:=claim_seq.nextval;
value := check_if_exists(spid,pol_id,pat_name,s_date);---Feature 9.1( Checks if the inputted values are valid or not)
	if value=0 then
		dbms_output.put_line('Claim Accepted!!');
    
    insert into claims values(clmid,0,0,uid,spid,pol_id,s_date);
			else	
		dbms_output.put_line('Claim Denied!!!');	
    goto end_now;
   end if;
   
servicecovered := check_if_covered(pol_id,service,s_date,pat_name); ---Feature 9.2( Checks if the inputted values are valid or not)
	if servicecovered=0 then
		dbms_output.put_line('Service Accepted!!');
			insert into claim_line values(clmid,service,'accepted',charge,0,0,0,0,0,0,0);
       else	
		dbms_output.put_line('Service Denied!!!');	
    insert into claim_line values(clmid,service,'denied',charge,0,0,0,0,0,0,0);
	end if;

alreadyexists := already_exists(spid ,pol_id,pat_name,s_date ,service,clmid); ---Feature 9.3( s if the inputted values are valid or not)
	if alreadyexists=0 then
		dbms_output.put_line('Service Accepted!!');
    		else	
		dbms_output.put_line('Service Denied!!!');	
	end if;
  
--feature 9.4
select cov_allowed_charge into allowed_charge from policy p, HEALTH_INSURANCE_PLANS hp,coveragee c where hp.PLAN_ID=p.PLAN_ID and p.POLICY_ID=pol_id and hp.COV_ID=c.COV_ID and c.SER_ID=service;
dbms_output.put_line('Service Charged--'||charge);
dbms_output.put_line('Max_Allowed Charged--'||allowed_charge);

  if (allowed_charge <charge)then
  update claim_line set provider_charge=allowed_charge where service_id=service;
  dbms_output.put_line('Charge adjusted!!');
  else
  dbms_output.put_line('Charge not adjusted!!');
  end if;

---- feature 9.5

   select plan_amount_deductable into amt_ded from HEALTH_INSURANCE_PLANS hp, POLICY p where hp.PLAN_ID=p.PLAN_ID and p.POLICY_ID=pol_id;
   
   select deductable_paid into amt_ded_paid from policy where policy_id=pol_id;
   dbms_output.put_line('AmoutDed--'||amt_ded);
   dbms_output.put_line('AmoutDed Paid--'||amt_ded_paid);
   
   if (amt_ded=amt_ded_paid)then
   update claim_line set amount_of_ded=0 where claim_id=clmid; 
  elsif (amt_ded_paid<amt_ded)then
  update claim_line set amount_of_ded=amt_ded-amt_ded_paid where claim_id=clmid; 
  else
  dbms_output.put_line('');
  end if;
--Feature 9.6
if (amt_ded!=amt_ded_paid)then
chargetobepaid :=calculate_charge(spid,charge,pol_id,service,clmid);
else
dbms_output.put_line('No charge to be paid,deductable alredy covered!');
end if;

update claim_line set MAX_OUT_POCKET_PAID=MAX_OUT_POCKET_PAID+chargetobepaid where claim_id=clmid;
update claim_line set MAX_OUT_POCKET_PAID_FAMILY=MAX_OUT_POCKET_PAID_FAMILY+chargetobepaid where claim_id=clmid;

select provider_charge into p_charge from claim_line where claim_id=clmid;
remaining:=p_charge-chargetobepaid;
dbms_output.put_line('Remaining amount to be paid--'||remaining);

if(remaining!=0)then
  if (amt_ded!=0)then
  chargetobepaid_n:=calculate_nextcharge(spid,charge,pol_id,service,clmid,remaining);
  else
  dbms_output.put_line('No charge to be paid,deductable alredy covered!');
end if;
else
dbms_output.put_line('No charge to be paid,charge alredy covered!');
end if;

dbms_output.put_line('Charge to be paid after 9.7:'||chargetobepaid_n);
totalcharge:=chargetobepaid+chargetobepaid_n;
dbms_output.put_line('Total Charge:'||totalcharge);
update  claim_line set amount_paid_cust=totalcharge where claim_id=clmid;
select sum(amount_paid_cust) into sum_claim from claim_line where claim_id=clmid group by claim_id;
select sum(amount_paid_ins) into sum_claim_ins from claim_line where claim_id=clmid group by claim_id;


update claims set total_charge_cust=sum_claim where claim_id=clmid;
update claims set total_charge_ins=sum_claim_ins where claim_id=clmid;
 
<<end_now>>
dbms_output.put_line('');
End;


--Functions

create or replace function check_if_exists(spid in number,pol_id in number,pat_name in varchar,s_date in date) 
return number
IS
serp_id number;
policyid number;
patientname varchar(20);
id number;
id1 number;
serdate number;
date1 number;
count_neg number; --- this variable checks if any of the inputted value is not valid(a reason for the claim to get denied!)

BEGIN
  count_neg:=0;
  --Check if service provider exists in the database or not
	select count(*)into serp_id from SERVICE_PROVIDER where sp_id = spid;
	if serp_id=0 then 
  --dbms_output.put_line('No such service provider in the database!!');
  insert into message values(seq_message.nextval,id1,'No such service provider in the database!!',sysdate);
  count_neg:=count_neg+1;
	else
  dbms_output.put_line('Given service provider present in the database!!');
	end if;
  
  --Check if the policy exists in the database or not
  select count(*)into policyid from policy where policy_id = pol_id;
	if policyid=0 then 
  dbms_output.put_line('No such policy in the database!!');
  insert into message values(seq_message.nextval,id1,'No such policy in the database!!',sysdate);
  count_neg:=count_neg+1;
	else
  dbms_output.put_line('Given policy present in the database!!');
	end if;

  
  --Check if the paient name is linked with the given policy or not
  select cust_id into id from policy where policy_id=pol_id;
  select user_id into id1 from user_info where USER_NAME=pat_name;
	if id=id1 then 
  dbms_output.put_line('Given patient is associated with the given policy!!');
  else
  dbms_output.put_line('Given patient is not associated with the given policy_id!!');
  insert into message values(seq_message.nextval,id1,'No such user in the database!!',sysdate);
  count_neg:=count_neg+1;
	end if;
  
  -- Check if the service date falls with the taken plan year or not  
  select EXTRACT(YEAR FROM plan_year) into date1 from HEALTH_INSURANCE_PLANS hp,policy p where p.PLAN_ID=hp.PLAN_ID and p.POLICY_ID=pol_id;
  serdate:= extract(year from s_date);
	if serdate=date1 then 
  dbms_output.put_line('Given policy is within the plan year!!');
  else
  dbms_output.put_line('Given policy is not within the plan year!!');
  insert into message values(seq_message.nextval,id1,'Given policy is not within the plan year!!',sysdate);
  count_neg:=count_neg+1;
	end if;
 
  return count_neg;
  exception
	when no_data_found then
	dbms_output.put_line('Invalid Data!!');
	return count_neg;
End;

--

create or replace function check_if_covered(pol_id in number,service in number,s_date date,pat_name varchar) 
return number
IS
policyid number;
cid number;
uid number;
ser_all number;
ser_used number;
date1 date;
count_neg number;
BEGIN
  count_neg:=0;
	select user_id into UID from user_info where USER_NAME=pat_name;

  select count(*) into policyid from policy p, HEALTH_INSURANCE_PLANS hp,coveragee c where hp.PLAN_ID=p.PLAN_ID and p.POLICY_ID=pol_id and hp.COV_ID=c.COV_ID and c.SER_ID=service;
	select c.cov_id into cid from policy p, HEALTH_INSURANCE_PLANS hp,coveragee c where hp.PLAN_ID=p.PLAN_ID and p.POLICY_ID=pol_id and hp.COV_ID=c.COV_ID and c.SER_ID=service;

  if policyid>0 then
    select COV_NO_OF_SERVICES_ALLOWED,SERVICES_USED into ser_all,ser_used from policy p, HEALTH_INSURANCE_PLANS hp,coveragee c where hp.PLAN_ID=p.PLAN_ID and p.POLICY_ID=pol_id and hp.COV_ID=c.COV_ID and c.SER_ID=service;
    select plan_year into date1 from HEALTH_INSURANCE_PLANS hp,policy p where p.PLAN_ID=hp.PLAN_ID and p.POLICY_ID=pol_id;
    
    if s_date>=date1 and s_date<=s_date+interval'1'year then 
    dbms_output.put_line('Service within date range');
    if ser_used>=ser_all then
    dbms_output.put_line('Service has reached its limit.Max number of services per year exceeded');
    dbms_output.put_line('Service has been denied');
    count_neg:=count_neg+1;
    insert into message values(seq_message.nextval,uid,'Service has reached max usage!!',sysdate);

    else
    dbms_output.put_line('Service has not reached its limit!!');
    update coveragee set services_used = services_used+1  Where coveragee.cov_id =  cid;
    dbms_output.put_line('Provided Service is covered in the policy!!');
    
    end if;
    end if;
    return count_neg; 
  else
  dbms_output.put_line('Provided Service is not covered in the policy!!');
  insert into message values(seq_message.nextval,uid,'Provided service not covered in the policy!!',sysdate);
   
  end if;
return count_neg;
exception
	when no_data_found then
	dbms_output.put_line('Invalid data!!');
	return 0;
End;


--
create or replace function already_exists(spid in number ,pol_id in number,pat_name in varchar,s_date in date,service in number,cid in number) 
return number
IS
exists_rec number;
status_r varchar(20);
BEGIN
	select count(*) into exists_rec from claims c,CLAIM_LINE cl,user_info u where c.claim_id=cl.CLAIM_ID and c.sp_id=spid and c.ser_date=s_date and c.policy_id=pol_id and cl.service_id= service and u.USER_NAME=pat_name and u.USER_ID=c.user_id and cl.CLAIM_ID!=cid; 
  
  if exists_rec=1 then
  select status into status_r from claims c,CLAIM_LINE cl,user_info u where c.claim_id=cl.CLAIM_ID and c.sp_id=spid and c.ser_date=s_date and c.policy_id=pol_id and cl.service_id= service and u.USER_NAME=pat_name and u.USER_ID=c.user_id; 
  if status_r='accepted' then
  dbms_output.put_line('Duplicate data!!');
  
  else
  dbms_output.put_line('Staus is rejected evenif all other values are same!!!');
  end if;
return 1;
else
dbms_output.put_line(' No duplicate data!!');
return 0;
end if;
 
exception
	when no_data_found then
	dbms_output.put_line('Invalid data!!');
	return 0;
End;

--
create or replace function calculate_charge(spid in number,charge in number,pol_id in number,service in number,cid number) 
return number
IS
remaining_out_mem number;
max_out_pocket_paid number;
max_out_pocket_paid_family number;
remaining_out_fam number;
type_sp varchar(20);
charge1 number;
copay number;
coins number;
copay_amount number;
coins_amount number;
max_paid number;
max_paid_f number;
pln_outofpocket_mem number;
pln_outofpocket_fam number;
smallest number;

mopm number;
mopf number;
BEGIN
select SP_TYPE into type_sp from service_provider where SP_ID=spid;
if type_sp ='Innetwork' then
  dbms_output.put_line('Innetwork!');
  select cov_in_network_copay into copay from coveragee c ,policy p where p.plan_id=c.PLAN_ID and p.POLICY_ID=pol_id and c.SER_ID=service;
  select cov_in_network_coin into coins from coveragee c ,policy p where p.plan_id=c.PLAN_ID and p.POLICY_ID=pol_id and c.SER_ID=service;
else
  dbms_output.put_line('Outnetwork!');
  select cov_out_network_copay into copay from coveragee c ,policy p where p.plan_id=c.PLAN_ID and p.POLICY_ID=pol_id and c.SER_ID=service;
  select cov_out_network_coin into coins from coveragee c ,policy p where p.plan_id=c.PLAN_ID and p.POLICY_ID=pol_id and c.SER_ID=service;
end if;

dbms_output.put_line('cid'||cid);

select plan_max_outofpocket_member into pln_outofpocket_mem from policy p,HEALTH_INSURANCE_PLANS hp where p.POLICY_ID=pol_id and p.plan_id=hp.PLAN_ID;
dbms_output.put_line('pln_outofpocket_mem'||pln_outofpocket_mem);
select plan_max_outofpocket_family into pln_outofpocket_fam from policy p,HEALTH_INSURANCE_PLANS hp where p.POLICY_ID=pol_id and p.plan_id=hp.PLAN_ID;
dbms_output.put_line('pln_outofpocket_fam'||pln_outofpocket_fam);
copay_amount:=copay;
 dbms_output.put_line('Copay'||copay_amount);
update claim_line set amount_of_copay=copay_amount where claim_id=cid and SERVICE_ID=service;
select provider_charge into charge1 from claim_line where claim_id=cid and SERVICE_ID=service;
dbms_output.put_line(charge1);
coins_amount:=(charge1)*coins/100;
 dbms_output.put_line('Coins'||coins_amount);

update claim_line set amount_of_coins=coins_amount where claim_id=cid and SERVICE_ID=service;
update claim_line set MAX_OUT_POCKET_PAID=AMOUNT_OF_DED+Amount_of_copay+amount_of_coins where claim_id=cid and SERVICE_ID=service;
update claim_line set MAX_OUT_POCKET_PAID_family=AMOUNT_OF_DED+Amount_of_copay+amount_of_coins where claim_id=cid and SERVICE_ID=service;
	
select MAX_OUT_POCKET_PAID into mopm from claim_line where claim_id=cid and SERVICE_ID=service;
select MAX_OUT_POCKET_PAID_family into mopf from claim_line where claim_id=cid and SERVICE_ID=service;
remaining_out_mem:=pln_outofpocket_mem-mopm;
remaining_out_fam:=pln_outofpocket_mem-mopf;


 dbms_output.put_line('remaining_out_mem!'||remaining_out_mem); dbms_output.put_line('remaining_out_fam!'||remaining_out_fam);
if(copay<charge and copay<remaining_out_mem and copay<remaining_out_fam)then
dbms_output.put_line('Copay is the samlles1');
smallest:= copay;
elsif(charge<copay and charge<remaining_out_mem and charge<remaining_out_fam)then
dbms_output.put_line('Charge is the samlles1');
smallest:=charge;
elsif(remaining_out_mem<copay and remaining_out_mem<charge and remaining_out_mem<remaining_out_fam)then
dbms_output.put_line('remaining_out_mem is the samlles1');
smallest:=remaining_out_mem;
update claim_line set max_out_pocket_paid=max_out_pocket_paid+smallest where claim_id=cid and SERVICE_ID=service;

--update remaining
else
dbms_output.put_line('remaining_out_fam is the samlles1');
smallest:=remaining_out_fam;
update claim_line set max_out_pocket_paid_family=max_out_pocket_paid_family+smallest where claim_id=cid and SERVICE_ID=service;


--update remaining charge

end if;

update claim_line set amount_paid_cust=smallest where claim_id=cid;
dbms_output.put_line('Amount to be paid by the customer:'||smallest);
return smallest;
End;
---
create or replace function calculate_nextcharge(spid in number,charge in number,pol_id in number,service in number,cid in number,remaining in number) 
return number
IS
remaining_out_mem number;
/* 1)max_out_pocket_paid number;
  2)max_out_pocket_paid_family number; */
  
remaining_out_fam number;
type_sp varchar(20);
charge1 number;
copay number;
coins number;
copay_amount number;
coins_amount number;
pln_outofpocket_mem number;
pln_outofpocket_fam number;
smallestq number;
max_paid number;
max_paid_f number;


BEGIN
select max_out_pocket_paid into max_paid from claim_line where claim_id=cid and SERVICE_ID=service;
select max_out_pocket_paid_family into max_paid_f from claim_line where claim_id=cid and SERVICE_ID=service;
dbms_output.put_line('max_out_pocket_paid'||max_paid);
dbms_output.put_line('max_out_pocket_paid_fam'||max_paid_f);

select plan_max_outofpocket_member into pln_outofpocket_mem from policy p,HEALTH_INSURANCE_PLANS hp where p.POLICY_ID=pol_id and p.plan_id=hp.PLAN_ID;
dbms_output.put_line('pln_outofpocket_mem'||pln_outofpocket_mem);
select plan_max_outofpocket_family into pln_outofpocket_fam from policy p,HEALTH_INSURANCE_PLANS hp where p.POLICY_ID=pol_id and p.plan_id=hp.PLAN_ID;
dbms_output.put_line('pln_outofpocket_fam'||pln_outofpocket_fam);

remaining_out_mem:=pln_outofpocket_mem-MAX_paid;
remaining_out_fam:=pln_outofpocket_mem-MAX_paid_f;
dbms_output.put_line('remaining_out_mem'||remaining_out_mem);
dbms_output.put_line('remaining_out_fam'||remaining_out_fam);

select amount_of_coins into coins from claim_line where claim_id=cid and SERVICE_ID=service;


if(pln_outofpocket_mem!=max_paid)then
  if( coins<remaining_out_mem and coins<remaining_out_fam)then
    dbms_output.put_line('Coins is the samlles1');
    smallestq:= coins;
  elsif(remaining_out_mem<coins and  remaining_out_mem<remaining_out_fam)then
    dbms_output.put_line('remaining_out_mem is the samlles1');
    smallestq:=remaining_out_mem;
  elsif(remaining_out_fam<coins and  remaining_out_fam<remaining_out_fam)then
    dbms_output.put_line('remaining_out_fam is the samlles1');
    smallestq:=remaining_out_fam;
end if;    
return smallestq;


else
  if(pln_outofpocket_mem=max_paid)then
    dbms_output.put_line('Individual limit reached!No money wud be cut!');
  elsif(pln_outofpocket_fam=max_paid_f)then
    dbms_output.put_line('Family limit reached!No money wud be cut!');
end if;
update claim_line set AMOUNT_PAID_INS=remaining where claim_id=cid;

return 0;
end if;
End; 
 

/* 10. Allow a user (customer of provider) to search for claims related to the user given a date range. The message will display the claim ID, provider, name of patient, service date (you can assume that services on the same claim is on the same date).*/ 
create or replace procedure search_claims(
customer_id in number,
start_date in date,
end_date in date) 
is 
cursor c1 is select c.claim_id, c.sp_id, u.user_name,c.ser_date from claims c , customer q, user_info u where c.user_id=q.cust_id and u.user_id=q.cust_id 
and u.user_id=c.user_id and c.ser_date >= start_date and c.ser_date <=end_date and c.user_id=customer_id;

cl_im_id claims.claim_id%type; 
s_p_id claims.sp_id%type; 
u_s_er user_info.user_name%type;
ser_dat claims.ser_date%type;
Begin 
open c1;
loop
fetch c1 into cl_im_id, s_p_id,u_s_er,ser_dat; 
exit when c1%notfound; 
dbms_output.put_line('claim id is ' ||cl_im_id||' with provider ID ' ||s_p_id|| ' with name of patient being ' || u_s_er|| ' with the service date being ' ||ser_dat); 
end loop; 
close c1;
exception
	when no_data_found then
		dbms_output.put_line('no such record!');
end;


/* 11) Display detail of a given claim. Please display detail information about the claim (including for each claim line) listed in Assumption 9.*/
 
create or replace procedure claim_detail(
claimm_id in claims.claim_id%type) 
is 
cursor c1 is select c.sp_id,l.service_id,c.user_id,c.policy_id,l.status,c.ser_date,l.provider_charge,l.amount_of_ded,l.amount_of_coins,l.amount_of_copay,l.amount_paid_cust,l.AMOUNT_PAID_INS,c.TOTAL_CHARGE_cust,c.total_charge_ins,l.max_out_pocket_paid,l.max_out_pocket_paid_family from claims c, claim_line l where c.claim_id=l.claim_id and c.claim_id=claimm_id;
/* with the help of join all details related to a claimed are loaded on to cursor and displayed*/

s_p_id claims.sp_id%type; 
s_er_id claim_line.service_id%type;
c_id claims.user_id%type;
pol_id claims.policy_id%type;
clm_sta claim_line.status%type;
c_s_d claims.ser_date%type;
c_p_c claim_line.provider_charge%type;
c_a_d claim_line.amount_of_ded%type;
c_a_co claim_line.amount_of_coins%type;
c_a_cop claim_line.amount_of_copay%type;
c_a_p_b_c claim_line.amount_paid_cust%type;
c_a_p_b_i_c Claim_line.AMOUNT_PAID_INS%type;
c_t_c CLAIMS.TOTAL_CHARGE_cust%type;
cti claims.total_charge_ins%type;
mopp claim_line.max_out_pocket_paid%type;
moppf claim_line.max_out_pocket_paid_family%type;

Begin 
open c1;
loop
fetch c1 into s_p_id,s_er_id,c_id,pol_id,clm_sta,c_s_d,c_p_c,c_a_d,c_a_co,c_a_cop,c_a_p_b_c,c_a_p_b_i_c,c_t_c,cti,mopp,moppf; 
exit when c1%notfound; 
dbms_output.put_line(s_p_id ||',' ||s_er_id || ',' || c_id || ',' || pol_id || ',' || clm_sta || ',' || c_s_d || ',' || c_p_c || ',' || c_a_d || ',' || c_a_co || ',' || c_a_cop || ',' || c_a_p_b_c || ',' || c_a_p_b_i_c || ',' || c_t_c|| ',' || cti || ',' || mopp|| ',' || moppf); 
end loop; 
close c1; end;

/*12. Display for a customer the total amount paid in a given plan year, the total deductible paid, the total co-pay paid, the total co-insurance paid, the total out-of-pocket cost for each member on the plan, and the total out-of-pocket cost for the whole family. Note that all these cost should only include accepted claims.*/

create or replace procedure print_totalamount(planyear number ,customer_id integer)
is
cursor c1 is select  
sum(AMOUNT_OF_COPAY),sum(AMOUNT_OF_DED),sum(AMOUNT_OF_COINS),sum(AMOUNT_PAID_CUST),sum(PLAN_MAX_OUTOFPOCKET_MEMBER),sum(PLAN_MAX_OUTOFPOCKET_FAMILY) 
from claim_line inner join claims on claims.CLAIM_ID = claim_line.CLAIM_ID inner join POLICY on claims.POLICY_ID=POLICY.POLICY_ID inner join 
HEALTH_INSURANCE_PLANS on POLICY.PLAN_ID=HEALTH_INSURANCE_PLANS.PLAN_ID
AND EXTRACT(YEAR FROM HEALTH_INSURANCE_PLANS.PLAN_YEAR)=planyear 
and POLICY.CUST_ID=customer_id and claim_line.status='accepted' ;
Claim_Deductable integer;
Claim_COIN number;
Claim_COPAY number;
Claim_Customer number;
Claim_outofpocket_member number;
Claim_outofpocket_family number;
X integer;
x1 number;
begin
select count(*) into X from customer where cust_id=customer_id;

select count(*) into x1 from HEALTH_INSURANCE_PLANS where EXTRACT(YEAR FROM HEALTH_INSURANCE_PLANS.PLAN_YEAR)=planyear;
if x=0 or x1=0
then dbms_output.put_line('Invalid customer! OR invalid year');
else
open c1;
loop
fetch c1 into Claim_Deductable,Claim_COIN,Claim_COPAY, Claim_Customer,Claim_outofpocket_member,Claim_outofpocket_family ;
exit when c1%notfound;
dbms_output.put_line('Deductable :'||  (Claim_Deductable) || ',COIN : ' ||  (Claim_COIN) || ',COPAY : ' || (Claim_COPAY) || ',cusomer : ' || (Claim_Customer)
 || ',outofpocket : ' || (Claim_outofpocket_member) || ',family : ' || (Claim_outofpocket_family) );
end loop;
close c1;
end if;
end;
/* 13. Display the total number of customers, total number of in-network service providers, the total number of policies per year in the past 5 years, the total number of claims submitted per year in the past 5 years, the total amount of premium received each year in the past 5 years, and the total amount of payment made by the insurance company each year in the past 5 years, and the total amount of payment made by the patients each year in the past 5 years.*/

create or replace procedure display is
x claims.claim_id%type;
b number;

cdata number;
ddata number;
tdata number;
idata number;

sun_year number;
sun_ppaid number;

sun_year2 number;
sun_amt number;

sun_year3 number;
sun_amt2 number;

sun_year4 number;
sun_amt3 number;

cursor c1 is select extract(year from ser_date), count (claim_id) as "Number of Claims" 
from claims
where ser_date >= sysdate - interval '5'year group by extract(year from ser_date) order by extract(year from ser_date) desc;

cursor c2 is select extract (year from ser_date) as ser_year, sum (premium_paid) as "Total Premium"
from policy, claims
where claims.policy_id=policy.policy_id and ser_date >= sysdate - interval '5'year
group by extract (year from ser_date);


cursor c3 is select extract (year from ser_date) as ser_year, sum(amount_paid_cust) as "Amount paid by Customers"
from claims, claim_line
where claims.claim_id=claim_line.claim_id and ser_date >= sysdate - interval '5'year
group by extract (year from ser_date);

cursor c4 is 
select extract (year from ser_date) as ser_year, sum(amount_paid_ins) as "Amount paid by company"
from claims, claim_line
where claims.claim_id=claim_line.claim_id and ser_date >= sysdate - interval '5'year
group by extract (year from ser_date);

cursor c5 is
select extract (year from ser_date) , count (policy_id)
from claims
where ser_date >= sysdate - interval '5'year
group by extract (year from ser_date);

begin
select count(cust_id) into cdata from customer; 
select count (dep_id) into ddata from dependent;

tdata:=cdata+ddata;
dbms_output.put_line('------------------------------------------');
dbms_output.put_line('Total number of customers is  '||tdata);

select count(sp_type) into idata from service_provider 
where sp_type like 'Innetwork';
dbms_output.put_line('------------------------------------------');
dbms_output.put_line('Total number of In-network service providers is  '||idata);

open c1;
loop 
fetch c1 into x,b;

exit when c1%notfound;
dbms_output.put_line('------------------------------------------');
dbms_output.put_line('Total claims every year for the last 5 years');
dbms_output.put_line('NUmber of claims ' || x ||' in the year ' ||b);

end loop;
close c1;

open c2;
loop
fetch c2 into sun_year,sun_ppaid;

exit when c2%notfound;
dbms_output.put_line('------------------------------------------');
dbms_output.put_line('Total premium paid every year for the last 5 years');
dbms_output.put_line('In the year ' ||sun_year|| ' total premium paid was '||sun_ppaid);

end loop;
close c2;

open c3;
loop
fetch c3 into sun_year2,sun_amt;

exit when c3%notfound;
dbms_output.put_line('------------------------------------------');
dbms_output.put_line('Total amount paid by cutomer every year for the last 5 years');
dbms_output.put_line(sun_year2||sun_amt);

end loop;
close c3;

open c4;
loop

fetch c4 into sun_year3,sun_amt2;

exit when c4%notfound;
dbms_output.put_line('------------------------------------------');
dbms_output.put_line('Total amount paid by Insurance every year for the last 5 years');
dbms_output.put_line(sun_year3||sun_amt2);

end loop;
close c4;

open c5;
loop

fetch c5 into sun_year4,sun_amt3;

exit when c5%notfound;
dbms_output.put_line('------------------------------------------');
dbms_output.put_line('Total number of policies every year for the last 5 years');
dbms_output.put_line('In the year '|| sun_year4||' there were '||sun_amt3||' policies');

end loop;
close c5;
end;
/* 14. For each medical service, compute the yearly usage statistics for the past 5 years. This includes the number of services appeared in claims each year, and the percentage of patients (customers and their dependents) who have used the service at least once in each year. Please also identify the top K (K as an integer input) services with the most claims in each year in the past 5 years, and the highest percentage of patients each year in past 5 years. */

----As this feature needed a lot of records we created two tables viz. 'CLAIM_SIDDHI' and 'CLAIM_LINE_SIDDHI' following are the create and insert statements

create table claim_siddhi
(
claim_id number,
user_id number, 
sp_id number,
claim_service_date date
);

create table claim_line_siddhi
(
claim_id number,
service_id number
);

insert into claim_siddhi values(1, 201, 32, date'2016-08-08');
insert into claim_siddhi values(2, 202, 32, date'2014-05-05');
insert into claim_siddhi values(3, 201, 36, date'2016-03-03');
insert into claim_siddhi values(4, 203, 36, date'2014-09-08');
insert into claim_siddhi values(5, 201, 32, date'2015-03-08');
insert into claim_siddhi values(6, 202, 36, date'2014-09-01');
insert into claim_siddhi values(7, 202, 37, date'2014-10-10');
insert into claim_siddhi values(8, 202, 38, date'2014-03-10');
insert into claim_siddhi values(9, 201, 39, date'2014-08-09');

insert into claim_line_siddhi values(1, 100);
insert into claim_line_siddhi values(2, 100);
insert into claim_line_siddhi values(3, 100);
insert into claim_line_siddhi values(4, 100);
insert into claim_line_siddhi values(5, 100);
insert into claim_line_siddhi values(6, 100);
insert into claim_line_siddhi values(7, 100);
insert into claim_line_siddhi values(8, 100);
insert into claim_line_siddhi values(9, 100);

select
    FirstSet.YEAR,
    FirstSet.Num_of_services,
    FirstSet.percentage,
    SecondSet.top_K_Services
from 
(
select TO_CHAR(CLAIM_SIDDHI.CLAIM_SERVICE_DATE, 'YYYY') as Year, 
    COUNT(DISTINCT(CLAIM_LINE_SIDDHI.SERVICE_ID)) as Num_of_services, 
    Cast(Cast((COUNT(DISTINCT(CLAIM_SIDDHI.USER_ID))/(SELECT COUNT(*) FROM USER_INFO))*100 as decimal(18,2)) as varchar(5))as Percentage
    from CLAIM_LINE_SIDDHI INNER JOIN CLAIM_SIDDHI ON CLAIM_SIDDHI.CLAIM_ID = CLAIM_LINE_SIDDHI.CLAIM_ID
    where CLAIM_SIDDHI.CLAIM_SERVICE_DATE > TRUNC(ADD_MONTHS(SYSDATE, -5*12))
group by TO_CHAR(CLAIM_SIDDHI.CLAIM_SERVICE_DATE, 'YYYY') 
)FirstSet
inner join
(
select vas.YEAR,
       listagg(case when seqnum <= 2 then SERVICE_ID end, ',') within group (order by seqnum) as top_K_Services
from (select TO_CHAR(CLAIM_SIDDHI.CLAIM_SERVICE_DATE, 'YYYY') as YEAR, SERVICE_ID, 
        row_number() over (partition by CLAIM_SERVICE_DATE order by count(*) desc) as seqnum
      from CLAIM_LINE_SIDDHI INNER JOIN CLAIM_SIDDHI on CLAIM_SIDDHI.CLAIM_ID = CLAIM_LINE_SIDDHI.CLAIM_ID
      group by CLAIM_LINE_SIDDHI.SERVICE_ID, CLAIM_SIDDHI.CLAIM_SERVICE_DATE
     ) vas
group by vas.YEAR
) SecondSet
on FirstSet.YEAR = SecondSet.YEAR
order by FirstSet.YEAR;
 
/*15. Identify customers or providers with suspicious patterns to detect possible medical fraud (defined as services billed but not provided, and can be done by bad guys using identity of providers or patients). You can use the following rules to identify such policies: 1) the amount paid by insurance company in a certain year is X times larger (X is input) than previous year for the customer or provider; 2) the average amount per patient/member paid by insurance in a certain year is Y times (Y as input) larger than previous year for the customer or provider (so this will exclude the case when the increase is due to more patients/member).*/ 

----As this feature needed a lot of records we created a table viz. 'CLAIM_NITIN' following are the create and insert statements

create table claim_nitin
(
claim_id integer,
cust_id integer,
claim_year integer,
claim_amt_by_ins_co integer
);

insert into claim_nitin values(301, 1, 2015, 100);  
insert into claim_nitin values(302, 1, 2015, 200);  
insert into claim_nitin values(303, 1, 2015, 300);  
insert into claim_nitin values(304, 1, 2016, 200);  
insert into claim_nitin values(305, 1, 2016, 400);  
insert into claim_nitin values(306, 1, 2016, 600);  
insert into claim_nitin values(307, 2, 2015, 120);  
insert into claim_nitin values(308, 2, 2015, 220);  
insert into claim_nitin values(309, 2, 2015, 320);  
insert into claim_nitin values(310, 2, 2016, 240);  
insert into claim_nitin values(311, 2, 2016, 440);  
insert into claim_nitin values(312, 2, 2016, 640);  
----Also, we created two fraud tables for SUM and AVERAGE
create table fraud(year number,cust_id number, sum_paid number);
create table fraud2(year number,cust_id number, avg_paid number);
create or replace procedure display1(times in number) is
a number;
b number;
c number;
e number;
f number;
g number;
sum1 number;
sum2 number;
avg1 number;
avg2 number;

cursor c1 is SELECT claim_year,cust_id ,(SUM(claim_amt_by_ins_co))
FROM claim_nitin
GROUP BY claim_year, cust_id;
cursor c2 is SELECT claim_year,cust_id ,(AVG(claim_amt_by_ins_co))
FROM claim_nitin
GROUP BY claim_year, cust_id;
begin
open c1;
DBMS_OUTPUT.PUT_LINE('Part1');
loop
fetch c1 into a, b, c;
exit when c1%notfound;
dbms_output.put_line(a || ' '  || b || ' ' || c);
insert into fraud values(a, b, c);
end loop;
DBMS_OUTPUT.PUT_LINE(' ');
close c1;

select sum_paid into sum1 from fraud where year=2015 and cust_id=1;
dbms_output.put_line(sum1);
select sum_paid into sum2 from fraud where year=2016 and cust_id=1;
dbms_output.put_line(sum2);

if(sum2>=sum1*times)then
DBMS_OUTPUT.PUT_LINE('This is a Fraud');
else
DBMS_OUTPUT.PUT_LINE('This is not a Fraud');
end if;

DBMS_OUTPUT.PUT_LINE(' ');
open c2;
DBMS_OUTPUT.PUT_LINE('Part2');
loop
fetch c2 into e, f, g;
exit when c2%notfound;
dbms_output.put_line(e || ' ' || f || ' ' || g );
insert into fraud values(e, f, g);
end loop;
close c2;

end;
