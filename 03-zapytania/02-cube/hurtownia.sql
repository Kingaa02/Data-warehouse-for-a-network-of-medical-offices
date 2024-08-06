--1) To zapytanie umożliwia analizę liczby wizyt w różnych typach gabinetów oraz sposobach opłaty, co pozwala na lepsze zrozumienie preferencji pacjentów i efektywniejsze zarządzanie zasobami gabinetów.


SELECT 
    NVL(TO_CHAR(wh.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL(TO_CHAR(wh.typ_gabinetu_id), 'RAZEM TYP GABINETU') AS id_typ_gabinetu,
    NVL(TO_CHAR(wh.typ_oplaty_id), 'RAZEM TYP OPLATY') AS id_typ_oplaty,
    COUNT(*) AS ilosc_wizyt
FROM 
    wizyta_hurt wh
GROUP BY CUBE(wh.gabinet_id, wh.typ_gabinetu_id, wh.typ_oplaty_id);


--2) To zapytanie analizuje liczbę wizyt w poszczególnych gabinetach, uwzględniając różne typy gabinetów, co pozwala na śledzenie wykorzystania gabinetów i sprzętu w kontekście wizyt pacjentów.

SELECT 
    NVL(TO_CHAR(w.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL(TO_CHAR(w.typ_gabinetu_id), 'RAZEM TYP GABINETU') AS id_typ_gabinetu,
    COUNT(*) AS ilosc_wizyt
FROM 
    wizyta_hurt w
GROUP BY CUBE(w.gabinet_id, w.typ_gabinetu_id);


--3) Zapytanie zbiera informacje o ilości wizyt dla każdego pacjenta wraz z detalami dotyczącymi tych wizyt, takimi jak identyfikator wizyty, data wizyty i numer gabinetu, jeśli są dostępne.


SELECT 
    NVL(TO_CHAR(pac.pacjent_id), 'RAZEM PACJENCI') AS id_pacjenta,
    NVL((SELECT imie || ' ' || nazwisko FROM pacjent_hurt WHERE TO_CHAR(pacjent_id) = pac.pacjent_id), 'RAZEM PACJENCI') AS pacjent,
    NVL(TO_CHAR(w.wizyta_id), 'RAZEM WIZYTY') AS id_wizyty,
    NVL(TO_CHAR(w.miesiac_id), 'RAZEM MIESIACE') AS miesiac_id,
    NVL(TO_CHAR(w.rok_id), 'RAZEM LATA') AS rok_id,
    NVL(TO_CHAR(w.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL((SELECT TO_CHAR(numer) FROM gabinet_hurt WHERE TO_CHAR(gabinet_id) = w.gabinet_id), 'RAZEM GABINETY') AS numer_gabinetu,
    COUNT(*) AS ilosc_wizyt
FROM 
    pacjent_hurt pac
    LEFT JOIN wizyta_hurt w ON pac.pacjent_id = w.pacjent_id
GROUP BY CUBE(pac.pacjent_id, w.wizyta_id, w.gabinet_id, w.rok_id, w.miesiac_id), pac.pacjent_id, w.gabinet_id;
