LOAD DATA
INFILE 'ulica.csv'
INTO TABLE ulica
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(ulica_id, nazwa, miasto_id)