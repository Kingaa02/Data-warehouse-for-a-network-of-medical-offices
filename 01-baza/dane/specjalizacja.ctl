LOAD DATA
INFILE 'specjalizacja.csv'
INTO TABLE specjalizacja
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(specjalizacja_id, nazwa, wysokosc_zarobkow_id)