--
-- HACKTON DATABASE
--

-- Type of encoding 
SET client_encoding = 'UTF8';
-- When you name of table is empty
SET default_tablespace = '';
--
SET check_function_bodies = false;
-- Messagge to Alert
SET client_min_messages = warning;
-- 
SET standard_conforming_strings = on;

-- DROP TABLES (TO UPDATE THE DATABASE)

DROP TABLE IF EXISTS application CASCADE;
DROP TABLE IF EXISTS application_stage CASCADE;
DROP TABLE IF EXISTS stage CASCADE;
DROP TABLE IF EXISTS candidate CASCADE;
DROP TABLE IF EXISTS vacant CASCADE;

-- CREATE THE TABLES
-- CLEAN DATES WITH (NULL VALUE IN CVG TO NO INSERT IN DATABASE)

CREATE TABLE vacant(
	id INT PRIMARY KEY,
	title VARCHAR(255),
	description TEXT,
	salary_type VARCHAR(15),
	min_salary INT,
	max_salary INT,
	status SMALLINT,
	created_at DATE,
	company VARCHAR(100),
	education_level VARCHAR(255),
	agree BOOL,
	requirements TEXT,
	publish_date DATE,
	confidential BOOL,
	expiration_date DATE,
	experience_and_positions TEXT,
	knowledge_and_skills TEXT,
	titles_and_studies TEXT,
	number_of_quotas INT);

CREATE TABLE candidate(
	id INT PRIMARY KEY,
	email CHARACTER VARYING(100) UNIQUE,
	first_name CHARACTER VARYING(10000),
	last_name CHARACTER VARYING(255),
	phone CHARACTER VARYING(14),
	birthdate DATE,
	gender CHARACTER VARYING(100),
	identification_type SMALLINT,
	identification_number CHARACTER VARYING(255),
	country_birth CHARACTER VARYING(255),
	city CHARACTER VARYING(255),
	education_level CHARACTER VARYING(255),
	salary INT,
	profile_description TEXT,
	without_experience BOOL,
	without_studies BOOL,
	title_or_profession VARCHAR(1000),
	available_to_move BOOL,
	civil_status VARCHAR(30),
	has_video TEXT,
	studies JSONB,
	experiences JSONB,
	psy_tests JSONB);

CREATE TABLE application(
	id INT PRIMARY KEY,
	vacant_id INT REFERENCES vacant (id),
	candidate_id INT REFERENCES candidate (id),
	created_at DATE,
	status VARCHAR(15),
	discard_type VARCHAR(12));

CREATE TABLE stage(
	id INT PRIMARY KEY,
	title VARCHAR(255),
	send_sms BOOL,
	send_email BOOL,
	send_call BOOL,
	stage_type INT,
	vacant_id INT REFERENCES vacant (id),
	stage_order INT);
	
CREATE TABLE application_stage(
	id INT PRIMARY KEY,
	application_id INT REFERENCES application (id),
	stage_id INT REFERENCES stage (id),
	created_at TIME,
	status VARCHAR(15));

-- DEFINE THE RELATIONS BETWEEN TABLE

-- EXAMPLE TO COPY CSV TO SQL
COPY PUBLIC.vacant FROM '/home/machinemmus/Documents/Hackaton2020/DataHackaton/Vacants.csv' DELIMITER ',' CSV;
COPY PUBLIC.candidate FROM '/home/machinemmus/Documents/Hackaton2020/DataHackaton/Candidates.csv' DELIMITER ',' CSV;
COPY PUBLIC.application FROM '/home/machinemmus/Documents/Hackaton2020/DataHackaton/Applications.csv' DELIMITER ',' CSV;
COPY PUBLIC.stage FROM '/home/machinemmus/Documents/Hackaton2020/DataHackaton/Stages.csv' DELIMITER ',' CSV;
COPY PUBLIC.application_stage FROM '/home/machinemmus/Documents/Hackaton2020/DataHackaton/ApplicationStages.csv' DELIMITER ',' CSV;

