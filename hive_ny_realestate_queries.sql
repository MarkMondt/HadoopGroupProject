CREATE DATABASE IF NOT EXISTS ny_realestate;
USE ny_realestate;

DROP TABLE IF EXISTS realestate_data;
CREATE TABLE realestate_data (
    id INT,
    borough INT,
    neighborhood STRING,
    building_class_category STRING,
    tax_class_at_present STRING,
    block INT,
    lot INT,
    ease_ment STRING,
    buidling_class_at_present STRING,
    address STRING,
    apartment_number STRING,
    zipcode INT,
    residential_units INT,
    commerical_units INT,
    total_units INT,
    gross_square_feet STRING,
    year_built INT,
    tax_class_at_time_of_sale INT,
    building_class_at_time_of_sale STRING,
    sale_price STRING,
    sale_date TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH 'nyc-rolling-sales.csv' OVERWRITE INTO TABLE realestate_data;

SELECT * FROM realestate_data LIMIT 10;
