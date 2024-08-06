--1) Zapytanie wyświetla informacje o pacjentach, ich wizytach, oraz lokalizacji gabinetów lekarskich oraz liczbę wizyt dla każdego pacjenta.

SELECT 
    pac.pacjent_id,
    pac.imie || ' ' || pac.nazwisko AS pacjent,
    w.wizyta_id,
    w.data AS data_wizyty,
    ul.nazwa AS nazwa_ulicy,
    gl.nazwa AS nazwa_gabinetu,
    COUNT(*) OVER(PARTITION BY pac.pacjent_id) AS ilosc_wizyt
FROM pacjent pac
LEFT JOIN wizyta w ON pac.pacjent_id = w.pacjent_id
LEFT JOIN gabinet_lekarski gl ON w.gabinet_id = gl.gabinet_lekarski_id
LEFT JOIN ulica ul ON gl.ulica_id = ul.ulica_id;

--2) Zapytanie zwraca zestawienie średniego wynagrodzenia pracowników o danej specjalizacji w danym państwie.

SELECT 
    p.panstwo_id,
    p.nazwa AS nazwa_panstwa,
    s.specjalizacja_id,
    s.nazwa AS nazwa_specjalizacji,
    AVG(wz.kwota) OVER(PARTITION BY p.panstwo_id, s.specjalizacja_id) AS srednie_wynagrodzenie
FROM 
    panstwo p
LEFT JOIN
    wojewodztwo w ON p.panstwo_id = w.panstwo_id
LEFT JOIN
    miasto m ON w.wojewodztwo_id = m.wojewodztwo_id
LEFT JOIN
    ulica u ON m.miasto_id = u.miasto_id
LEFT JOIN
    pracownik pr ON u.ulica_id = pr.ulica_id
LEFT JOIN
    specjalizacja s ON pr.specjalizacja_id = s.specjalizacja_id
LEFT JOIN
    wysokosc_zarobkow wz ON s.wysokosc_zarobkow_id = wz.wysokosc_zarobkow_id;

--3) Zapytanie zwraca zestawienie średniego wynagrodzenia pracowników o danej specjalizacji w danym województwie.

SELECT 
    w.wojewodztwo_id,
    w.nazwa AS nazwa_wojewodztwa,
    s.specjalizacja_id,
    s.nazwa AS nazwa_specjalizacji,
    AVG(wz.kwota) OVER(PARTITION BY w.wojewodztwo_id, s.specjalizacja_id) AS srednie_wynagrodzenie
FROM 
    wojewodztwo w
LEFT JOIN
    miasto m ON w.wojewodztwo_id = m.wojewodztwo_id
LEFT JOIN
    ulica u ON m.miasto_id = u.miasto_id
LEFT JOIN
    pracownik pr ON u.ulica_id = pr.ulica_id
LEFT JOIN
    specjalizacja s ON pr.specjalizacja_id = s.specjalizacja_id
LEFT JOIN
    wysokosc_zarobkow wz ON s.wysokosc_zarobkow_id = wz.wysokosc_zarobkow_id;