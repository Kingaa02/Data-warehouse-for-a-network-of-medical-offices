LOAD DATA
INFILE 'pacjent.csv'
INTO TABLE pacjent
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(pacjent_id, imie, nazwisko, nr_domu, nr_mieszkania, telefon, ulica_id, pesel)