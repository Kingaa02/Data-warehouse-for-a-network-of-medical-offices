LOAD DATA
INFILE 'typ_oplaty.csv'
INTO TABLE typ_oplaty
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(typ_oplaty_id, opis, kwota)