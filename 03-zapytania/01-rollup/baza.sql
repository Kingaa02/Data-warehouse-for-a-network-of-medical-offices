--1) Zapytanie zlicza wizyty grupując je według pracowników, specjalizacji i gabinetów, jednocześnie tworząc sumy częściowe na różnych poziomach szczegółowości.

SELECT 
    NVL(TO_CHAR(p.pracownik_id), 'RAZEM PRACOWNICY') AS id_pracownika,
    NVL((SELECT imie || ' ' || nazwisko FROM pracownik WHERE TO_CHAR(pracownik_id) = p.pracownik_id), 'RAZEM PRACOWNICY') AS pracownik,
    NVL(TO_CHAR(s.specjalizacja_id), 'RAZEM SPECJALIZACJE') AS id_specjalizacji,
    NVL((SELECT nazwa FROM specjalizacja WHERE TO_CHAR(specjalizacja_id) = s.specjalizacja_id), 'RAZEM SPECJALIZACJE') AS specjalizacja,
    NVL(TO_CHAR(w.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL((SELECT TO_CHAR(numer) FROM gabinet WHERE TO_CHAR(gabinet_id) = w.gabinet_id), 'RAZEM GABINETY') AS numer_gabinetu,
    COUNT(*) AS ilosc_wizyt
FROM 
    pracownik p
    LEFT JOIN specjalizacja s ON p.specjalizacja_id = s.specjalizacja_id
    LEFT JOIN wizyta w ON p.pracownik_id = w.pracownik_id
GROUP BY ROLLUP(p.pracownik_id, s.specjalizacja_id, w.gabinet_id);

--2) Zapytanie grupuje wizyty według pracowników, pacjentów i wizyt, obliczając jednocześnie ilość wizyt na każdym poziomie, a także podsumowując dla wszystkich pracowników, wszystkich pacjentów i wszystkich wizyt.

SELECT 
    NVL(TO_CHAR(p.pracownik_id), 'RAZEM PRACOWNICY') AS id_pracownika,
    NVL((SELECT imie || ' ' || nazwisko FROM pracownik WHERE TO_CHAR(pracownik_id) = p.pracownik_id), 'RAZEM PRACOWNICY') AS pracownik,
    NVL(TO_CHAR(w.pacjent_id), 'RAZEM PACJENCI') AS id_pacjenta,
    NVL((SELECT imie || ' ' || nazwisko FROM pacjent WHERE TO_CHAR(pacjent_id) = w.pacjent_id), 'RAZEM PACJENCI') AS pacjent,
    NVL(TO_CHAR(w.wizyta_id), 'RAZEM WIZYTY') AS id_wizyty,
    NVL(TO_CHAR(w.data), 'RAZEM WIZYTY') AS data_wizyty,
    COUNT(*) AS ilosc_wizyt
FROM 
    pracownik p
    LEFT JOIN wizyta w ON p.pracownik_id = w.pracownik_id
    LEFT JOIN pacjent pac ON w.pacjent_id = pac.pacjent_id
GROUP BY ROLLUP(p.pracownik_id, w.pacjent_id,  w.wizyta_id), w.data;

-- 3) Zapytanie pozwala analizować liczbę wizyt medycznych, grupując je według pacjentów, wizyt oraz miast, z których pochodzą pacjenci, oraz umożliwia uzyskanie podsumowań liczby wizyt na poziomie szczegółowych wizyt dla każdego pacjenta, sumarycznych wizyt dla pacjentów w miastach, oraz ogólnych sumarycznych wizyt.
 
SELECT 
    NVL(TO_CHAR(pac.pacjent_id), 'RAZEM PACJENCI') AS id_pacjenta,
    NVL((SELECT imie || ' ' || nazwisko FROM pacjent_hurt WHERE pacjent_id = pac.pacjent_id), 'RAZEM PACJENCI') AS pacjent,
    NVL(TO_CHAR(w.wizyta_id), 'RAZEM WIZYTY') AS id_wizyty,
    'N/A' AS data_wizyty,  -- Ponieważ nie mamy pola data w tabeli wizyta_hurt
    'N/A' AS miasto_id,    -- Ponieważ nie mamy tabeli miasto
    COUNT(*) AS ilosc_wizyt
FROM 
    pacjent pac
    LEFT JOIN wizyta w ON pac.pacjent_id = w.pacjent_id
GROUP BY ROLLUP(pac.pacjent_id, w.wizyta_id);
