--1) Zapytanie pozwala na wygenerowanie raportu dotyczącego wizyt pacjentów, uwzględniając szczegóły dotyczące opłat za te wizyty. Numeracja wierszy dla każdego pacjenta może być przydatna do monitorowania kolejności wizyt dla danego pacjenta w czasie, co może ułatwić zarządzanie harmonogramem i organizację pracy personelu medycznego.
 SELECT 
    pac.pacjent_id,
    pac.imie || ' ' || pac.nazwisko AS pacjent,
    w.wizyta_id,
    t.opis AS typ_oplaty,
    t.kwota AS kwota,
    w.data AS data_wizyty,
    ROW_NUMBER() OVER (
        PARTITION BY pac.pacjent_id 
        ORDER BY w.data) AS numer_wiersza
FROM pacjent pac
LEFT JOIN wizyta w ON pac.pacjent_id = w.pacjent_id
LEFT JOIN typ_oplaty t ON w.typ_oplaty_id = t.typ_oplaty_id;

--2) Zapytanie generuje numerację wizyt dla każdego pacjenta w poszczególnych miastach.

SELECT 
    m.nazwa AS nazwa_miasta,
    pac.imie || ' ' || pac.nazwisko AS pacjent,
    w.data AS data_wizyty,
    ROW_NUMBER() OVER (PARTITION BY m.miasto_id ORDER BY w.data) AS numer_wizyty
FROM miasto m
JOIN ulica u ON m.miasto_id = u.miasto_id
JOIN pacjent pac ON u.ulica_id = pac.ulica_id
JOIN wizyta w ON pac.pacjent_id = w.pacjent_id;



--3) Zapytanie generuje średnią liczbę wizyt w okresie czasu dla każdego pracownika w poszczególnych gabinetach, co pozwala na analizę aktywności poszczególnych pracowników w gabinetach.

SELECT 
    gl.nazwa AS nazwa_gabinetu,
    p.imie || ' ' || p.nazwisko AS pracownik,
    TO_CHAR(w.data, 'YYYY-MM-DD') AS data_wizyty,
    COUNT(w.wizyta_id) OVER (PARTITION BY gl.gabinet_lekarski_id, p.pracownik_id, TO_CHAR(w.data, 'YYYY-MM-DD')) AS liczba_wizyt_dziennie
FROM gabinet_lekarski gl
JOIN pracownik p ON gl.gabinet_lekarski_id = p.gabinet_lekarski_id
LEFT JOIN wizyta w ON p.pracownik_id = w.pracownik_id
ORDER BY gl.nazwa, p.imie, p.nazwisko, TO_CHAR(w.data, 'YYYY-MM-DD');
