CREATE TABLE person
(
p_id int,
last_name VARCHAR(100),
first_name VARCHAR(100),
email varchar(100),
affiliation varchar(100),
start_date date,
end_date date,

PRIMARY KEY (p_id)
);


CREATE TABLE student
(
p_id int,
PRIMARY KEY (p_id),
FOREIGN KEY (p_id) REFERENCES person(p_id)
);


CREATE TABLE employee
(
p_id int,
supervisor_id int ,
PRIMARY KEY (p_id),
FOREIGN KEY (p_id) REFERENCES person(p_id),
FOREIGN KEY (supervisor_id) REFERENCES employee(p_id)
);

CREATE TABLE academic
(
p_id int,
PRIMARY KEY (p_id),
FOREIGN KEY (p_id) REFERENCES employee(p_id)
);

CREATE TABLE Non_academic
(
p_id int,
PRIMARY KEY (p_id),
FOREIGN KEY (p_id) REFERENCES employee(p_id)
);

CREATE TABLE advises
(
p_id int,
student_id int ,
PRIMARY KEY (p_id,student_id),
FOREIGN KEY (p_id) REFERENCES academic(p_id),
FOREIGN KEY (student_id) REFERENCES student(p_id)
);

CREATE TABLE faculty
(
p_id int,
PRIMARY KEY (p_id),
FOREIGN KEY (p_id) REFERENCES academic(p_id)
);

CREATE TABLE Administrative
(
p_id int,
PRIMARY KEY (p_id),
FOREIGN KEY (p_id) REFERENCES Non_academic(p_id)
);
CREATE TABLE Technical
(
p_id int,
PRIMARY KEY (p_id),
FOREIGN KEY (p_id) REFERENCES Non_academic(p_id)
);




CREATE TABLE laboratory
(
l_id int,
p_id int ,
name VARCHAR(100),
room_num int,
building varchar(100),
discipline varchar(100),


PRIMARY KEY (l_id),
FOREIGN KEY (p_id) REFERENCES faculty(p_id)
);

CREATE TABLE Attached
(
l_id int,
p_id int ,
PRIMARY KEY (l_id,p_id),
FOREIGN KEY (l_id) REFERENCES laboratory(l_id),
FOREIGN KEY (p_id) REFERENCES person(p_id)
);

CREATE TABLE research_project
(
code int,
title varchar(100) ,
r_status varchar(100),
start_date date ,
end_date date ,
PRIMARY KEY (code)
);

CREATE TABLE involves
(
p_id int,
code int ,
role varchar(100),
PRIMARY KEY (code,p_id),
FOREIGN KEY (code) REFERENCES reseach_project(code),
FOREIGN KEY (p_id) REFERENCES person(p_id)
);

CREATE TABLE budget
(
b_id int,
p_id int ,
acc_granted int ,
acc_disbursed int,
start_date date ,
end_date date ,
PRIMARY KEY (b_id),
FOREIGN KEY (p_id) REFERENCES academic(p_id)

);

CREATE TABLE funded_byR
(
code int,
b_id int ,

PRIMARY KEY (code,b_id),
FOREIGN KEY (code) REFERENCES reseach_project(code),
FOREIGN KEY (b_id) REFERENCES budget(b_id)
);

CREATE TABLE funded_byL
(
l_id int,
b_id int ,

PRIMARY KEY (l_id,b_id),
FOREIGN KEY (l_id) REFERENCES laboratory(l_id),
FOREIGN KEY (b_id) REFERENCES budget(b_id)
);

CREATE TABLE equipment_model
(
e_id int,
name varchar(100) ,
category varchar(100),
special_training varchar(100) ,
manufacturer varchar(100) ,
required_envir varchar(100),
PRIMARY KEY (e_id)
);


CREATE TABLE equipment_unit
(
serial_num int,
status varchar(100) ,
acquisition_date date,
purchase_cost int ,
is_portable varchar(100),
PRIMARY KEY (serial_num) ,
e_id int ,
FOREIGN KEY (e_id) REFERENCES equipment_model(e_id),
l_id int ,
FOREIGN KEY (l_id) REFERENCES laboratory(l_id)

);

CREATE TABLE certification
(
code int,
title varchar(100) ,
issuing_authority varchar(100),
safety_level varchar(100) ,
validity_period int,

PRIMARY KEY (code)
);



CREATE TABLE requires
(
code int,
e_id int ,

PRIMARY KEY (code,e_id),
FOREIGN KEY (code) REFERENCES certification(code),
FOREIGN KEY (e_id) REFERENCES equipment_model(e_id)
);


CREATE TABLE holds
(
code int,
p_id int ,
issue_date date ,
expiration_date date ,
grade varchar(100),

PRIMARY KEY (code,p_id),
FOREIGN KEY (code) REFERENCES certification(code),
FOREIGN KEY (p_id) REFERENCES person(p_id)
);

CREATE TABLE Reservation
(
r_id int,
purpose varchar(100) ,
status varchar(100),
planned_time int ,
timestamp datetime,
start_time datetime,
p_id int,
approver_id int ,
code int,
PRIMARY KEY (r_id),
FOREIGN KEY (p_id) REFERENCES person(p_id),
FOREIGN KEY (approver_id) REFERENCES employee(p_id),
FOREIGN KEY (code) REFERENCES reseach_project(code)

);

CREATE TABLE made_for
(
r_id int,
serial_num int ,


PRIMARY KEY (r_id,serial_num),
FOREIGN KEY (r_id) REFERENCES Reservation(r_id),
FOREIGN KEY (serial_num) REFERENCES equipment_unit(serial_num)
);

CREATE TABLE Maintenance
(
serial_num int ,
p_id int ,
type varchar(100) ,
description varchar(255),
cost int ,
start_time datetime,
end_time datetime,
outcome varchar(100),
FOREIGN KEY (serial_num) REFERENCES equipment_unit(serial_num),
FOREIGN KEY (p_id) REFERENCES Technical(p_id),
PRIMARY KEY (serial_num,start_time)


);


CREATE TABLE calibration
(
serial_num int ,
result varchar(100) ,
remarks varchar(255),
calib_type varchar(100),
calibration_date date,
next_due_date date ,


FOREIGN KEY (serial_num) REFERENCES equipment_unit(serial_num),
PRIMARY KEY (serial_num,calibration_date)


);


CREATE TABLE consumable
(
c_id int ,
name varchar(100) ,
unit_measur varchar(100),
hazard_lvl varchar(100),
reorder int,
PRIMARY KEY (c_id)

);

CREATE TABLE occupy
(
c_id int,
l_id int ,
quantity int ,
p_id int ,
last_stock_date date ,
storage_condition varchar(255),

PRIMARY KEY (c_id,l_id),
FOREIGN KEY (p_id) REFERENCES Technical(p_id),
FOREIGN KEY (c_id) REFERENCES consummable(c_id),
FOREIGN KEY (l_id) REFERENCES laboratory(l_id)
);

CREATE TABLE reserved
(
l_id int,
c_id int ,
r_id int ,
quantity int ,


PRIMARY KEY (c_id,l_id,r_id),
FOREIGN KEY (c_id,l_id) REFERENCES occupy(c_id,l_id),
FOREIGN KEY (r_id) REFERENCES Reservation(r_id)
);
   
CREATE TABLE supplier
(
s_id int ,
name varchar(100) ,
email varchar(255),

phone varchar(25),
PRIMARY KEY (s_id)

);



   
CREATE TABLE supplies
(
l_id int,
s_id int ,
c_id  int ,
unit_price int,
PRIMARY KEY (l_id,s_id,c_id),
FOREIGN KEY (l_id) REFERENCES laboratory(l_id),
FOREIGN KEY (s_id) REFERENCES supplier(s_id),
FOREIGN KEY (c_id) REFERENCES consumable(c_id)
);