DROP DATABASE IF EXISTS Amazon_Review CASCADE;
CREATE DATABASE Amazon_Review;

set hivevar:PathFiles=/Amazon_Review;


--Creando tablas CSV
DROP TABLE IF EXISTS Amazon_Review.FACT_Ratings_CSV;   --Items (In data Source)
CREATE TABLE Amazon_Review.FACT_Ratings_CSV (
	UserID STRING
	, ASIN STRING
	, Rating TINYINT
	, TimeStamp BIGINT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	STORED AS TEXTFILE;

DROP TABLE IF EXISTS Amazon_Review.DIM_Items_CSV;
CREATE TABLE  Amazon_Review.DIM_Items_CSV (
	ASIN STRING
	, Title STRING
	, SalesRank STRING
	, Brand STRING
	, Category STRING
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH  '${hivevar:PathFiles}/item_dedup.csv.bz2' OVERWRITE INTO TABLE Amazon_Review.FACT_Ratings_CSV;
LOAD DATA LOCAL INPATH  '${hivevar:PathFiles}/metadata.csv.bz2' OVERWRITE INTO TABLE Amazon_Review.DIM_Items_CSV;


DROP TABLE IF EXISTS Amazon_Review.FACT_Ratings;   --Items ()
CREATE TABLE Amazon_Review.FACT_Ratings (
	UserID STRING
	, ASIN STRING
	, Rating TINYINT
	, Time STRING
	)
	stored as orc tblproperties ("orc.compress"="SNAPPY");

DROP TABLE IF EXISTS Amazon_Review.DIM_Items;
CREATE TABLE  Amazon_Review.DIM_Items (
	ASIN STRING
	, Title STRING
	, SalesRank STRING
	, Brand STRING
	, Category STRING
	)
	stored as orc tblproperties ("orc.compress"="SNAPPY");

insert into table Amazon_Review.FACT_Ratings select UserID,ASIN, Rating, from_unixtime(TimeStamp, 'yyyy-MM-dd') from Amazon_Review.FACT_Ratings_csv;
insert into table Amazon_Review.DIM_Items select * from Amazon_Review.DIM_Items_csv;


DROP VIEW IF EXISTS Amazon_Review.FACT_Ratings_View;
Create View Amazon_Review.FACT_Ratings_View AS
 Select UserID 
	, ASIN 
	, Rating 
	, Time 
	, IF (Rating=1, 1, 0) as ONE
	, IF (Rating=2, 1, 0) as TWO
	, IF (Rating=3, 1, 0) as THREE
	, IF (Rating=4, 1, 0) as FOUR
	, IF (Rating=5, 1, 0) as FIVE
	From Amazon_Review.FACT_Ratings;


DROP VIEW IF EXISTS Amazon_Review.DIM_Items_View;
Create View Amazon_Review.DIM_Items_View AS
 Select ASIN 
	, Brand 
	, Category 
	From Amazon_Review.DIM_Items;

-- Select ASIN from Amazon_Review.DIM_Items group by ASIN having count (1) >1;
-- select from_unixtime(TimeStamp, 'yyyy-MM-dd') from Amazon_Review.FACT_Ratings_csv limit 1;
-- Select * from Amazon_Review.FACT_Ratings  limit 1;
-- Select count(1) from Amazon_Review.FACT_Ratings;
-- Select * from Amazon_Review.DIM_Items  limit 1;
-- Select count(1) from Amazon_Review.DIM_Items;
-- Select * from Amazon_Review.FACT_Ratings_View  limit 1;
-- Select * from Amazon_Review.DIM_Items_View  limit 1;

-- Select category from Amazon_Review.DIM_Items  limit 1;
-- Select count(1) from Amazon_Review.DIM_Items where category="Books";
