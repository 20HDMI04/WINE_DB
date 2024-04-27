# 1. Általános Információk

- **Adatbázis neve:** WINE_DB
- **Cél:** Az adatbázis célja hogy szervezett és hatékony módon tárolja és kezelje a borok, a szőlőfajták és a borvidékek adatait illetve a borversenyek adatait.
- **DBMS**: MariaDB 11.1.2
- **Tárolási motor:** InnoDB
- **Karakter kódolás:** *utf8mb4_general_ci*
- **Szoftverek:** [XAMPP](https://www.apachefriends.org/), [Docker](https://www.docker.com/)
- **Kezelő felület:** [phpMyAdmin](https://hub.docker.com/_/phpmyadmin)
- **Létrehozási dátum**: *2024.04.27*
- **Frissítési előzmények:** *2024.04.27 - Első verzió*
# 2. Adatbázis-terv

## Entitások

- Borok
- Szőlőfajták
- Borvidékek
- Parcellák
- Borversenyek
- *Linker entitások*
## Táblák és Adattípusaik

### 1. Borok:
- **borok_id:**  Elsődleges kulcs (*int*, *unsigned*, *Primary key*, AI[^1])
- **borok_name:** A borok nevei (*varchar*, 255)
- **borok_vintage:** A borok évjárata években (*year*)
- **borok_mix:** A borok keverékek-e, *0=false, 1=true* (tinyint)
- **borok_producer:** A borok gyárójának neve melyet a könnyebb beazonosíthatóság miatt tartunk a táblában. (*varchar*, 255)

[^1]: *Auto Increment*
### 2. Szolofajtak:[^2]
- **szolofajtak_borid:** Idegen kulcs a Borok táblából (borok_id) (*int*, *unsigned*)
- **szolofajtak_szolotipus:** Az adott bor szőlőfajtájának típusa (pl.: vörös) (*varchar*, *255*)
- **szolofajtak_szoloneve:** Az adott bor szőlőfajtája (pl.: Kadarka) (*varchar*, *255*)

[^2]: A tábla azért létezik mert habár Borvidekek_Parcellai táblában már szerepel egy hasonló adat az ebben a táblában azok az adatok vannak melyek megmutatják hogy az adott bor miből készült míg a másik táblában csak az Adott parcellában termelt szőlőt mutatja meg ami hivatkozik a Vidékre de ha egy bor ezen az adott vidéken készült az nem jelenti azt hogy a földeken még mindig ugyanaz a szőlők vannak ott. 
### 3. Borversenyek:
- **borverseny_name:** Az adott verseny nevét adja meg amin nyert a bor (*varchar*, *255*)
- **borverseny_date:** Az adott verseny dátumát adja meg (*date*)
- **borverseny_borid:** Idegen kulcs a Borok táblából (borok_id) (*int*, *unsigned*)
- **borverseny_dij:** Az adott versenyen elért helyezést írja le (*varchar*, *255*)

### 4. Bor_Borvidek_Linker:
- **linker_bor_id:** Idegen kulcs a Borok táblából (borok_id) (*int*, *unsigned*)
- **linker_borvidek_id:** Idegen kulcs a Borvidekek táblából (b) (*int*, *unsigned*)