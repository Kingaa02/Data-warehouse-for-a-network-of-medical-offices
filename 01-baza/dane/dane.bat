@echo off
SET oracle_sid=xe
SET uid=C##user01
SET pwd=ztbduser




sqlldr %uid%/%pwd%@%oracle_sid% control=panstwo.ctl log=panstwo.log bad=panstwo.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=wojewodztwo.ctl log=wojewodztwo.log bad=wojewodztwo.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=miasto.ctl log=miasto.log bad=miasto.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=ulica.ctl log=ulica.log bad=ulica.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=wysokosc_zarobkow.ctl log=wysokosc_zarobkow.log bad=wysokosc_zarobkow.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=typ_gabinetu.ctl log=typ_gabinetu.log bad=typ_gabinetu.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=gabinet.ctl log=gabinet.log bad=gabinet.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=sprzet.ctl log=sprzet.log bad=sprzet.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=sprzet_w_gabinecie.ctl log=sprzet_w_gabinecie.log bad=sprzet_w_gabinecie.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=typ_oplaty.ctl log=typ_oplaty.log bad=typ_oplaty.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=pacjent.ctl log=pacjent.log bad=pacjent.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=specjalizacja.ctl log=specjalizacja.log bad=specjalizacja.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=gabinet_lekarski.ctl log=gabinet_lekarski.log bad=gabinet_lekarski.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=pracownik.ctl log=pracownik.log bad=pracownik.bad
sqlldr %uid%/%pwd%@%oracle_sid% control=wizyta.ctl log=wizyta.log bad=wizyta.bad


echo Zakończono zasilanie bazy danych.
pause