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
[^2]: 
