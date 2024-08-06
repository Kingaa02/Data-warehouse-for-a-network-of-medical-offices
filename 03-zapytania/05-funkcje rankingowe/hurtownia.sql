--1) Zapytanie zwraca ranking pracowników pod względem liczby wizyt w poszczególnych gabinetach.

SELECT 
    w.gabinet_lekarski_id AS gabinet_lekarski_id,
    w.pracownik_id AS pracownik_id,
    COUNT(w.wizyta_id) AS liczba_wizyt,
    RANK() OVER (PARTITION BY w.gabinet_lekarski_id ORDER BY COUNT(w.wizyta_id) DESC) AS ranking
FROM wizyta_hurt w
GROUP BY w.gabinet_lekarski_id, w.pracownik_id, w.gabinet_lekarski_id;


--2) Zapytanie zwraca ranking specjalizacji lekarzy w poszczególnych miastach na podstawie liczby pacjentów.

SELECT
    w.miasto_id,
    w.specjalizacja_id,
    COUNT(w.pacjent_id) AS liczba_pacjentow,
    RANK() OVER (PARTITION BY w.miasto_id ORDER BY COUNT(w.pacjent_id) DESC) AS ranking
FROM
    wizyta_hurt w
GROUP BY
    w.miasto_id, w.specjalizacja_id
ORDER BY
    w.miasto_id, ranking;


--3) Zapytanie zwraca ranking gabinetów lekarskich w poszczególnych miastach na podstawie liczby pracowników.

SELECT
    w.miasto_id,
    w.gabinet_lekarski_id,
    COUNT(w.pracownik_id) AS liczba_pracownikow,
    RANK() OVER (PARTITION BY w.miasto_id ORDER BY COUNT(w.pracownik_id) DESC) AS ranking
FROM
    wizyta_hurt w
GROUP BY
    w.miasto_id, w.gabinet_lekarski_id
ORDER BY
    w.miasto_id, ranking;