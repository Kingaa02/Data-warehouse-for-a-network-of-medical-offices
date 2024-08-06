--1) To zapytanie umożliwia analizę liczby wizyt w różnych typach gabinetów oraz sposobach opłaty, co pozwala na lepsze zrozumienie preferencji pacjentów i efektywniejsze zarządzanie zasobami gabinetów.

SELECT 
    NVL(TO_CHAR(g.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL((SELECT opis FROM typ_gabinetu WHERE typ_gabinetu_id = g.typ_gabinetu_id), 'RAZEM TYP GABINETU') AS typ_gabinetu,
    NVL(TO_CHAR(w.typ_oplaty_id), 'RAZEM TYP OPLATY') AS id_typ_oplaty,
    NVL((SELECT opis FROM typ_oplaty WHERE typ_oplaty_id = w.typ_oplaty_id), 'RAZEM TYP OPLATY') AS typ_oplaty,
    COUNT(*) AS ilosc_wizyt
FROM 
    gabinet g
    LEFT JOIN wizyta w ON g.gabinet_id = w.gabinet_id
GROUP BY CUBE(g.gabinet_id, g.typ_gabinetu_id, w.typ_oplaty_id);

--2) To zapytanie analizuje liczbę wizyt w poszczególnych gabinetach, uwzględniając różne typy gabinetów oraz sprzęt znajdujący się w tych gabinetach, co pozwala na śledzenie wykorzystania gabinetów i sprzętu w kontekście wizyt pacjentów.

SELECT 
    NVL(TO_CHAR(g.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL((SELECT opis FROM typ_gabinetu WHERE typ_gabinetu_id = g.typ_gabinetu_id), 'RAZEM TYP GABINETU') AS typ_gabinetu,
    NVL(TO_CHAR(s.sprzet_id), 'RAZEM SPRZET') AS id_sprzet,
    COUNT(*) AS ilosc_wizyt
FROM 
    gabinet g
    LEFT JOIN wizyta w ON g.gabinet_id = w.gabinet_id
    LEFT JOIN sprzet_w_gabinecie swg ON g.gabinet_id = swg.gabinet_id
    LEFT JOIN sprzet s ON swg.sprzet_id = s.sprzet_id
GROUP BY CUBE(g.gabinet_id, g.typ_gabinetu_id, s.sprzet_id);

--3) Zapytanie zbiera informacje o ilości wizyt dla każdego pacjenta wraz z detalami dotyczącymi tych wizyt, takimi jak identyfikator wizyty, data wizyty i numer gabinetu, jeśli są dostępne.
SELECT 
    NVL(TO_CHAR(pac.pacjent_id), 'RAZEM PACJENCI') AS id_pacjenta,
    NVL((SELECT imie || ' ' || nazwisko FROM pacjent WHERE TO_CHAR(pacjent_id) = pac.pacjent_id), 'RAZEM PACJENCI') AS pacjent,
    NVL(TO_CHAR(w.wizyta_id), 'RAZEM WIZYTY') AS id_wizyty,
    NVL(TO_CHAR(w.data), 'RAZEM WIZYTY') AS data_wizyty,
    NVL(TO_CHAR(w.gabinet_id), 'RAZEM GABINETY') AS id_gabinetu,
    NVL((SELECT TO_CHAR(numer) FROM gabinet WHERE TO_CHAR(gabinet_id) = w.gabinet_id), 'RAZEM GABINETY') AS numer_gabinetu,
    COUNT(*) AS ilosc_wizyt
FROM 
    pacjent pac
    LEFT JOIN wizyta w ON pac.pacjent_id = w.pacjent_id
GROUP BY CUBE(pac.pacjent_id, w.wizyta_id, w.gabinet_id), pac.pacjent_id, w.data, w.gabinet_id;