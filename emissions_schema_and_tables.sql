
-- Uncomment to create schema
CREATE SCHEMA emissions;

CREATE TABLE substance_dimension (
	  substance_id INT PRIMARY KEY,
	  cas_number VARCHAR(20),
	  release_group VARCHAR(20),
	  substance_name VARCHAR(100),
	  substance_category VARCHAR(50)
);

CREATE TABLE release_dimension (
	  release_group_id INT PRIMARY KEY,
	  release_year INT,
	  release_group VARCHAR(50)
);

CREATE TABLE industry_dimension (
	  industry_id INT PRIMARY KEY,
	  naics_code VARCHAR(10),
	  naics_title VARCHAR(100)
);

CREATE TABLE company_dimension (
	  company_id INT PRIMARY KEY,
	  company_name VARCHAR(100),
	  npri_id VARCHAR(20),
	  industry_id INT,
	  -- Mailing Address
  road VARCHAR(100),
  city VARCHAR(50),
  province_state VARCHAR(50),
  postal_code VARCHAR(10),
  -- country VARCHAR(50), 
  FOREIGN KEY (industry_id) REFERENCES industry_dimension(industry_id)
);

CREATE TABLE facility_dimension (
	  facility_id INT PRIMARY KEY,
	  company_id INT,
	  company_name VARCHAR(100),
	  facility_name VARCHAR(100),
	  province VARCHAR(50),
	  FOREIGN KEY (company_id) REFERENCES company_dimension(company_id)
);

CREATE TABLE location_dimension (
	  location_id INT PRIMARY KEY,
	  facility_id INT,
	  city VARCHAR(50),
	  province VARCHAR(50),
	  postal_code VARCHAR(10),
	  FOREIGN KEY (facility_id) REFERENCES facility_dimension(facility_id)
);

CREATE TABLE fact_table (
	  release_group_id INT,
	  substance_id INT,
	  release_year INT,
	  release_quantity DECIMAL(10,2),
	  -- foreign keys to all other dimensions (assuming corresponding dimension tables exist)
  facility_id INT,
  location_id INT,
  company_id INT,
  industry_id INT,
  FOREIGN KEY (release_group_id) REFERENCES release_dimension(release_group_id),
  FOREIGN KEY (substance_id) REFERENCES substance_dimension(substance_id),
  FOREIGN KEY (facility_id) REFERENCES facility_dimension(facility_id),
  FOREIGN KEY (location_id) REFERENCES location_dimension(location_id),
  FOREIGN KEY (company_id) REFERENCES company_dimension(company_id),
  FOREIGN KEY (industry_id) REFERENCES industry_dimension(industry_id)
);

