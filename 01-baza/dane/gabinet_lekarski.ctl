LOAD DATA
INFILE 'gabinet_lekarski.csv'
INTO TABLE gabinet_lekarski
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(gabinet_lekarski_id, nazwa, nr_domu, nr_mieszkania, telefon, email, ulica_id)