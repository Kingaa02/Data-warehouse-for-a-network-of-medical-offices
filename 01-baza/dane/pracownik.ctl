LOAD DATA
INFILE 'pracownik.csv'
INTO TABLE pracownik
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(pracownik_id, imie, nazwisko, nr_domu, nr_mieszkania, telefon, ulica_id, specjalizacja_id, gabinet_lekarski_id)