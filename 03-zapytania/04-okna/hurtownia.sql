--1) Zapytanie pozwala na wygenerowanie raportu dotyczącego wizyt pacjentów, uwzględniając szczegóły dotyczące opłat za te wizyty. Numeracja wierszy dla każdego pacjenta może być przydatna do monitorowania kolejności wizyt dla danego pacjenta w czasie, co może ułatwić zarządzanie harmonogramem i organizację pracy personelu medycznego.

 SELECT 
    w.pacjent_id,
    w.wizyta_id,
    w.typ_oplaty_id AS typ_oplaty_id,
    t.kwota AS kwota,
    w.rok_id AS rok_id,
    w.miesiac_id AS miesiac_id,
    ROW_NUMBER() OVER (
        PARTITION BY w.pacjent_id 
        ORDER BY w.rok_id, w.miesiac_id) AS numer_wiersza
FROM wizyta_hurt w
LEFT JOIN typ_oplaty t ON w.typ_oplaty_id = t.typ_oplaty_id;

--2) Zapytanie generuje numerację wizyt dla każdego pacjenta w poszczególnych miastach.

 SELECT 
    w.miasto_id AS miasto_id,
    w.pacjent_id AS pacjent_id,
    w.rok_id AS rok_id,
    w.miesiac_id AS miesiac_id,
    ROW_NUMBER() OVER (PARTITION BY w.miasto_id ORDER BY w.rok_id, w.miesiac_id) AS numer_wizyty
FROM wizyta_hurt w;


--3) Zapytanie generuje średnią liczbę wizyt w okresie czasu dla każdego pracownika w poszczególnych gabinetach, co pozwala na analizę aktywności poszczególnych pracowników w gabinetach.

SELECT 
    w.gabinet_lekarski_id AS gabinet_lekarski_id,
    w.pracownik_id AS pracownik_id,
    w.rok_id AS rok_id_wizyty,
    w.miesiac_id AS miesiac_id_wizyty,
    COUNT(w.wizyta_id) OVER (PARTITION BY w.gabinet_lekarski_id, w.pracownik_id, w.rok_id, w.miesiac_id) AS liczba_wizyt_dziennie
FROM wizyta_hurt w
ORDER BY w.gabinet_lekarski_id, w.pracownik_id, w.rok_id, w.miesiac_id;