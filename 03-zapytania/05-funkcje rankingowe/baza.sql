--1) Zapytanie zwraca ranking pracowników pod względem liczby wizyt w poszczególnych gabinetach.

SELECT 
    gl.nazwa AS nazwa_gabinetu,
    p.pracownik_id AS pracownik_id,
    COUNT(w.wizyta_id) AS liczba_wizyt,
    RANK() OVER (PARTITION BY gl.gabinet_lekarski_id ORDER BY COUNT(w.wizyta_id) DESC) AS ranking
FROM gabinet_lekarski gl
JOIN pracownik p ON gl.gabinet_lekarski_id = p.gabinet_lekarski_id
LEFT JOIN wizyta w ON p.pracownik_id = w.pracownik_id
GROUP BY gl.nazwa, p.pracownik_id, gl.gabinet_lekarski_id;

--2) Zapytanie zwraca ranking specjalizacji lekarzy w poszczególnych miastach na podstawie liczby pacjentów.

SELECT
    m.miasto_id,
    s.specjalizacja_id,
    COUNT(w.pacjent_id) AS liczba_pacjentow,
    RANK() OVER (PARTITION BY m.miasto_id ORDER BY COUNT(w.pacjent_id) DESC) AS ranking
FROM
    wizyta w
JOIN
    pracownik p ON w.pracownik_id = p.pracownik_id
JOIN
    specjalizacja s ON p.specjalizacja_id = s.specjalizacja_id
JOIN
    gabinet_lekarski gl ON p.gabinet_lekarski_id = gl.gabinet_lekarski_id
JOIN
    ulica ul ON gl.ulica_id = ul.ulica_id
JOIN
    miasto m ON ul.miasto_id = m.miasto_id
GROUP BY
    m.miasto_id, s.specjalizacja_id
ORDER BY
    m.miasto_id, ranking;

--3) Zapytanie zwraca ranking gabinetów lekarskich w poszczególnych miastach na podstawie liczby pracowników.

SELECT
    m.miasto_id,
    gl.gabinet_lekarski_id,
    COUNT(p.pracownik_id) AS liczba_pracownikow,
    RANK() OVER (PARTITION BY m.miasto_id ORDER BY COUNT(p.pracownik_id) DESC) AS ranking
FROM
    pracownik p
JOIN
    gabinet_lekarski gl ON p.gabinet_lekarski_id = gl.gabinet_lekarski_id
JOIN
    ulica ul ON gl.ulica_id = ul.ulica_id
JOIN
    miasto m ON ul.miasto_id = m.miasto_id
GROUP BY
    m.miasto_id, gl.gabinet_lekarski_id
ORDER BY
    m.miasto_id, ranking;