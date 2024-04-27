# 1. Általános Információk
---------------------------------------------------------------------
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
--------------------------------------------------------------------
## Entitások

- Borok
- Szőlőfajták
- Borvidékek
- Parcellák
- Borversenyek
- *Linker entitások*
## Táblák és Adattípusaik
--------------------------------------------------
### 1. Borok:
- **borok_id:**  Elsődleges kulcs (*int*, *unsigned*, *Primary key*)
- **borok_name:** A borok nevei (*varchar*)
- **borok_vintage:** A borok évjárata években (*year*)
- borok_mix: A borok