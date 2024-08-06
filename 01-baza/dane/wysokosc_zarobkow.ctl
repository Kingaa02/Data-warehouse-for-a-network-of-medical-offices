LOAD DATA
INFILE 'wysokosc_zarobkow.csv'
INTO TABLE wysokosc_zarobkow
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(wysokosc_zarobkow_id, kwota)