LOAD DATA
INFILE 'typ_gabinetu.csv'
INTO TABLE typ_gabinetu
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(typ_gabinetu_id, opis)