LOAD DATA
INFILE 'wizyta.csv'
INTO TABLE wizyta
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
    wizyta_id,
    data DATE "YYYY-MM-DD",
    godzina "TO_DSINTERVAL('0 ' || :godzina)",
    pacjent_id,
    pracownik_id,
    gabinet_id,
    typ_oplaty_id
)