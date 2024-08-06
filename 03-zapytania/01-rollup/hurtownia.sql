--1) Zapytanie zlicza wizyty grupując je według pracowników, specjalizacji i gabinetów, jednocześnie tworząc sumy częściowe na różnych poziomach szczegółowości.

SELECT 
    NVL(TO_CHAR(w.pracownik_id), 'RAZEM PRACOWNICY') AS id_pracownika,
    NVL(TO_CHAR(w.specjalizacja_id), 'RAZEM SPECJALIZACJE') AS id_specjalizacji,
    NVL(TO_CHAR(w.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL((SELECT TO_CHAR(numer) FROM gabinet_hurt WHERE gabinet_id = w.gabinet_id), 'RAZEM GABINETY') AS numer_gabinetu,
    COUNT(*) AS ilosc_wizyt
FROM 
    wizyta_hurt w
GROUP BY ROLLUP(w.pracownik_id, w.specjalizacja_id, w.gabinet_id);

--2) Zapytanie grupuje wizyty według pracowników, pacjentów i wizyt, obliczając jednocześnie ilość wizyt na każdym poziomie, a także podsumowując dla wszystkich pracowników, wszystkich pacjentów i wszystkich wizyt.

SELECT 
    NVL(TO_CHAR(w.pracownik_id), 'RAZEM PRACOWNICY') AS id_pracownika,
    NVL(TO_CHAR(w.pacjent_id), 'RAZEM PACJENCI') AS id_pacjenta,
    NVL(TO_CHAR(w.wizyta_id), 'RAZEM WIZYTY') AS id_wizyty,
    NVL(TO_CHAR(w.miesiac_id), 'RAZEM WIZYTY') AS id_miesiac,
    NVL(TO_CHAR(w.rok_id), 'RAZEM WIZYTY') AS id_rok,
    COUNT(*) AS ilosc_wizyt
FROM 
    pracownik_hurt p
    LEFT JOIN wizyta_hurt w ON p.pracownik_id = w.pracownik_id
GROUP BY ROLLUP(w.pracownik_id, w.pacjent_id, w.wizyta_id, w.miesiac_id, w.rok_id);


-- 3) Zapytanie pozwala analizować liczbę wizyt medycznych, grupując je według pacjentów, wizyt oraz miast, z których pochodzą pacjenci, oraz umożliwia uzyskanie podsumowań liczby wizyt na poziomie szczegółowych wizyt dla każdego pacjenta, sumarycznych wizyt dla pacjentów w miastach, oraz ogólnych sumarycznych wizyt.

SELECT 
    NVL(TO_CHAR(wh.pacjent_id), 'RAZEM PACJENCI') AS id_pacjenta,
    NVL(TO_CHAR(wh.wizyta_id), 'RAZEM WIZYTY') AS id_wizyty,
    NVL(TO_CHAR(wh.miesiac_id), 'RAZEM MIESIACE') AS miesiac_id,
    NVL(TO_CHAR(wh.rok_id), 'RAZEM LATA') AS rok_id,
    NVL(TO_CHAR(wh.miasto_id), 'N/A') AS miasto_id,
    COUNT(*) AS ilosc_wizyt
FROM 
    wizyta_hurt wh
GROUP BY ROLLUP(wh.pacjent_id, wh.wizyta_id, wh.miesiac_id, wh.rok_id, wh.miasto_id);