-- Migracja danych do hurtowni danych

-- Gabinet
INSERT INTO gabinet_hurt (gabinet_id, numer)
SELECT gabinet_id, numer
FROM gabinet;

-- Gabinet Lekarski
INSERT INTO gabinet_lekarski_hurt (gabinet_lekarski_id, nazwa)
SELECT gabinet_lekarski_id, nazwa
FROM gabinet_lekarski;

-- Pacjent
INSERT INTO pacjent_hurt (pacjent_id, imie, nazwisko)
SELECT pacjent_id, imie, nazwisko
FROM pacjent;

-- Typ Oplaty
INSERT INTO typ_oplaty_hurt (typ_oplaty_id, kwota)
SELECT typ_oplaty_id, kwota
FROM typ_oplaty;

-- Pracownik
INSERT INTO pracownik_hurt (pracownik_id, imie, nazwisko)
SELECT pracownik_id, imie, nazwisko
FROM pracownik;

-- Specjalizacja
INSERT INTO specjalizacja_hurt (specjalizacja_id)
SELECT specjalizacja_id
FROM specjalizacja;

-- Typ Gabinetu
INSERT INTO typ_gabinetu_hurt (typ_gabinetu_id, opis)
SELECT typ_gabinetu_id, opis
FROM typ_gabinetu;

-- Miasto
INSERT INTO miasto_hurt (miasto_id, nazwa)
SELECT miasto_id, nazwa
FROM miasto;

-- Województwo
INSERT INTO wojewodztwo_hurt (wojewodztwo_id, nazwa)
SELECT wojewodztwo_id, nazwa
FROM wojewodztwo;

-- Państwo
INSERT INTO panstwo_hurt (panstwo_id, nazwa)
SELECT panstwo_id, nazwa
FROM panstwo;

-- Ulica
INSERT INTO ulica_hurt (ulica_id, nazwa)
SELECT ulica_id, nazwa
FROM ulica;

-- Wysokość Zarobków
INSERT INTO wysokosc_zarobkow_hurt (wysokosc_zarobkow_id, kwota)
SELECT wysokosc_zarobkow_id, kwota
FROM wysokosc_zarobkow;

-- Sekwencja dla tabeli Rok
CREATE SEQUENCE rok_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Migracja danych do tabeli Rok
INSERT INTO rok_hurt (rok_id, numer)
SELECT rok_seq.NEXTVAL, rok
FROM (
    SELECT DISTINCT EXTRACT(YEAR FROM data) AS rok
    FROM wizyta
);

-- Sekwencja dla tabeli Miesiąc
CREATE SEQUENCE miesiac_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Migracja danych do tabeli Miesiąc
INSERT INTO miesiac_hurt (miesiac_id, opis)
SELECT miesiac_seq.NEXTVAL, opis
FROM (
    SELECT DISTINCT TO_CHAR(data, 'Month', 'NLS_DATE_LANGUAGE=POLISH') AS opis
    FROM wizyta
);



-- Migracja danych do tabeli Wizyta
INSERT INTO wizyta_hurt(
    wizyta_id,
    pacjent_id,
    gabinet_lekarski_id,
    miesiac_id,
    rok_id,
    typ_oplaty_id,
    gabinet_id,
    pracownik_id,
    specjalizacja_id,
    wysokosc_zarobkow_id,
    typ_gabinetu_id,
    ulica_id,
    miasto_id,
    wojewodztwo_id,
    panstwo_id)
SELECT 
    w.wizyta_id, 
    w.pacjent_id, 
    pr.gabinet_lekarski_id, 
    mh.miesiac_id, 
    rh.rok_id, 
    w.typ_oplaty_id, 
    w.gabinet_id, 
    w.pracownik_id,
    pr.specjalizacja_id,
    sp.wysokosc_zarobkow_id,
    g.typ_gabinetu_id,
    u.ulica_id,
    m.miasto_id,
    wj.wojewodztwo_id,
    pan.panstwo_id
FROM 
    wizyta w
JOIN 
    pracownik pr ON w.pracownik_id = pr.pracownik_id
JOIN 
    gabinet_lekarski gl ON pr.gabinet_lekarski_id = gl.gabinet_lekarski_id
JOIN 
    ulica u ON gl.ulica_id = u.ulica_id
JOIN 
    miasto m ON u.miasto_id = m.miasto_id
JOIN 
    wojewodztwo wj ON m.wojewodztwo_id = wj.wojewodztwo_id
JOIN 
    panstwo pan ON wj.panstwo_id = pan.panstwo_id
JOIN 
    specjalizacja sp ON pr.specjalizacja_id = sp.specjalizacja_id
JOIN 
    wysokosc_zarobkow wz ON sp.wysokosc_zarobkow_id = wz.wysokosc_zarobkow_id
JOIN 
    typ_gabinetu g ON w.gabinet_id = g.typ_gabinetu_id
JOIN 
    miesiac_hurt mh ON TO_CHAR(w.data, 'Month', 'NLS_DATE_LANGUAGE=POLISH') = mh.opis
JOIN 
    rok_hurt rh ON EXTRACT(YEAR FROM w.data) = rh.numer;








