LOAD DATA
INFILE 'miasto.csv'
INTO TABLE miasto
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(miasto_id, nazwa, wojewodztwo_id)
