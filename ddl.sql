DROP  TABLE Animal;
CREATE temporary TABLE Animal (
animal_id integer primary key,
lrid integer NOT NULL default 0,
tag varchar(16) NOT NULL default '',
rfid varchar(15) NOT NULL default '',
nlis varchar(16) NOT NULL default '',
is_new integer NOT NULL default 1,
draft varchar(20) NOT NULL default '',
sex varchar(20) NOT NULL default '',
dob timestamp,
sire varchar(16) NOT NULL default '',
dam varchar(16) NOT NULL default '',
breed varchar(20) NOT NULL default '',
colour varchar(20) NOT NULL default '',
weaned integer NOT NULL default 0 ,
prev_tag varchar(10) NOT NULL default '',
prev_pic varchar(20) NOT NULL default '',
note varchar(30) NOT NULL default '',
note_date timestamp,
is_exported integer NOT NULL default 0,
is_history integer NOT NULL default 0,
is_deleted integer NOT NULL default 0,
tag_sorter varchar(48) NOT NULL default '',
donordam varchar(16) NOT NULL default '',
whp timestamp,
esi timestamp,
status varchar(20) NOT NULL default '',
status_date timestamp,
overall_adg varchar(20) NOT NULL default '',
current_adg varchar(20) NOT NULL default '',
last_weight varchar(20) NOT NULL default '',
last_weight_date timestamp,
selected integer default 0,
animal_group varchar(20) NOT NULL default '',
current_farm varchar(20) NOT NULL default '',
current_property varchar(20) NOT NULL default '',
current_area varchar(20) NOT NULL default '',
current_farm_date timestamp,
current_property_date timestamp,
current_area_date timestamp,
animal_group_date timestamp,
sex_date timestamp,
breed_date timestamp,
dob_date timestamp,
colour_date timestamp,
prev_pic_date timestamp,
sire_date timestamp,
dam_date timestamp,
donordam_date timestamp,
prev_tag_date timestamp,
tag_date timestamp,
rfid_date timestamp,
nlis_date timestamp,
modified timestamp,
full_rfid varchar(16) default '',
full_rfid_date timestamp);
DROP TABLE Note;
CREATE temporary  TABLE Note (
animal_id integer NOT NULL,
created timestamp,
note varchar(30) NOT NULL,
session_id integer NOT NULL,
is_deleted integer default 0,
is_alert integer default 0,
primary key( animal_id, created ));
DROP TABLE SessionAnimalActivity;
CREATE temporary  TABLE SessionAnimalActivity (
session_id integer NOT NULL,
animal_id integer NOT NULL,
activity_code integer NOT NULL,
when_measured timestamp NOT NULL,
latestForSessionAnimal integer default 1,
latestForAnimal integer default 1,
is_history integer NOT NULL default 0,
is_exported integer NOT NULL default 0,
is_deleted integer default 0,
primary key( session_id, animal_id, activity_code, when_measured ));
DROP TABLE SessionAnimalTrait;
CREATE temporary  TABLE SessionAnimalTrait (
session_id integer NOT NULL,
animal_id integer NOT NULL,
trait_code integer NOT NULL,
alpha_value varchar(20) NOT NULL default '',
alpha_units varchar(10) NOT NULL default '',
when_measured timestamp NOT NULL,
latestForSessionAnimal integer default 1,
latestForAnimal integer default 1,
is_history integer NOT NULL default 0,
is_exported integer NOT NULL default 0,
is_deleted integer default 0,
primary key(session_id, animal_id, trait_code, when_measured));
DROP TABLE PicklistValue;
CREATE temporary  TABLE PicklistValue (
picklistvalue_id integer primary key,
picklist_id integer,
value varchar(30));
-- read the CSV file into the table
\copy Animal from 'Animal.csv' WITH DELIMITER ',' CSV HEADER;
-- read the CSV file into the table
\copy Note from 'Note.csv' WITH DELIMITER ',' CSV HEADER;
-- read the CSV file into the table
\copy SessionAnimalActivity from 'SessionAnimalActivity.csv' WITH
DELIMITER ',' CSV HEADER;
-- read the CSV file into the table
\copy SessionAnimalTrait from 'SessionAnimalTrait.csv' WITH DELIMITER ','
CSV HEADER;
-- read the CSV file into the table
\copy PicklistValue from 'PicklistValue.csv' WITH DELIMITER ',' CSV
HEADER;

Create table goat as select Animal_id, rfid, Tag, Dob, Dam, prev_tag sire from animal;
Create table birth_weight as select animal_id, alpha value from sessionanimaltrait where trait_code = 357;
Create table weight as select animal_id, alpha_value, when_measured from sessionanimaltrait where trait_code = 53; –used for winter and wean weights, waiting on clarification from stakeholder
Create table dam as select animal_id, distinct(dam), as dtag, prev_tag from goat;
Create table child as select animal_id, tag, dam from goat order by dam;

Create table Season_Month (
	Month integer primary key,
	Season integer foreign key references season
)
Create table Season (season integer primary key, seasonName varchar(6) not null)
