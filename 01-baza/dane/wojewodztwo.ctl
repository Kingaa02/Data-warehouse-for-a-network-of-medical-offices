LOAD DATA
INFILE 'wojewodztwo.csv'
INTO TABLE wojewodztwo
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(wojewodztwo_id, nazwa, panstwo_id)