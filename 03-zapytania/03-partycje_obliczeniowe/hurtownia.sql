--1) Zapytanie wyświetla informacje o pacjentach, ich wizytach, oraz lokalizacji gabinetów lekarskich oraz liczbę wizyt dla każdego pacjenta.

SELECT 
    w.pacjent_id,
    w.wizyta_id,
    w.rok_id AS rok_id,
    w.miesiac_id AS miesiac_id,
    w.ulica_id AS ulica_id,
    w.gabinet_LEKARSKI_ID AS gabinet_lekarski_id,
    COUNT(*) OVER(PARTITION BY w.pacjent_id) AS ilosc_wizyt
FROM wizyta_hurt w;

--2) Zapytanie zwraca zestawienie średniego wynagrodzenia pracowników o danej specjalizacji w danym państwie.

SELECT 
    w.panstwo_id,
    w.specjalizacja_id,
    AVG(wz.kwota) OVER(PARTITION BY w.panstwo_id, w.specjalizacja_id) AS srednie_wynagrodzenie
FROM 
    wizyta_hurt w
JOIN wysokosc_zarobkow_hurt wz ON w.wysokosc_zarobkow_id = wz.wysokosc_zarobkow_id;

--3) Zapytanie zwraca zestawienie średniego wynagrodzenia pracowników o danej specjalizacji w danym województwie.

SELECT 
    w.wojewodztwo_id,
    w.specjalizacja_id,
    AVG(wz.kwota) OVER(PARTITION BY w.wojewodztwo_id, w.specjalizacja_id) AS srednie_wynagrodzenie
FROM 
    wizyta_hurt w
LEFT JOIN
    wysokosc_zarobkow_hurt wz ON wz.wysokosc_zarobkow_id = w.wysokosc_zarobkow_id;