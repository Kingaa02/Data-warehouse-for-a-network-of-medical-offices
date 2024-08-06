LOAD DATA
INFILE 'sprzet_w_gabinecie.csv'
INTO TABLE sprzet_w_gabinecie
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(opis, sprzet_id, gabinet_id)