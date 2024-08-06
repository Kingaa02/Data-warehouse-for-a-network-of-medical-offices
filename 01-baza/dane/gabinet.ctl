LOAD DATA
INFILE 'gabinet.csv'
INTO TABLE gabinet
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(gabinet_id, numer, typ_gabinetu_id)