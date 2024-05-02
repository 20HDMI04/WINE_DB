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

### 4. Bor_Borvidek_Linker:[^3]
- **linker_bor_id:** Idegen kulcs a Borok táblából (borok_id) (*int*, *unsigned*)
- **linker_borvidek_id:** Idegen kulcs a Borvidekek táblából (borvidekek_id) (*int*, *unsigned*)

[^3]: A tábla azért létezik mert nem lehetett egy az egyben összekapcsolni a Borok és Borvidekek táblát mert egy bor több borvidékhez is tartozhat és hogy ne eredményezzen duplikált entitásokat elkészítettük ezt a táblát.

### 5. Borvidekek:
- **borvidekek_id:** Az adott vidék egyedi azonosítója (*int*, *unsigned*, *Primary key*, AI[^1])
- **borvidekek_name:** Az adott borvidék neve (*varchar*, *255*)
- **borvidekek_area:** Az adott borvidék területe hektárban (*double*, *unsigned*)

### 6. Borvidekek_Parcellai:
- **parcellak_borvidekid:** Idegen kulcs a Borvidekek táblából (borvidekek_id) (*int*, *unsigned*)
- **parcellak_parcellaid:** Az adott parcellának az azonosítója (*int*, *unsigned*)[^4]
- **parcellak_szolotipus:** Az adott parcellában termesztett szőlőfajtának a típusa (pl.: vörös)        (*varchar*, *255*)
- **parcellak_szolofajta:** Az adott parcellákban termesztett szőlőfajta (pl.: Kadarka)(*varchar*, *255*)
- **parcellak_terulet:** Az adott parcellák mérete hektárban (*double*, *unsigned*)

[^4]: Azért nem lehetett unique id mert ismétlődik a parcella szám és egy adott parcellát borvidekid-vel és parcellaid-vel lehet csak beazonosítani.

## Táblák Tervezői nézetben
![Táblák Tervezői nézetben](https://github.com/20HDMI04/WINE_DB/blob/CODE/assets/wine_db2.png)


## Példa a táblázatbeli adatokra
### Borok
| borok_id | borok_name                | borok_vintage | borok_mix | borok_producer    |
| -------- | ------------------------- | ------------- | --------- | ----------------- |
| 2        | Château Lafite Rothschild | 2010          | 1         | Rothschild family |
### Borversenyek
| borverseny_name            | borverseny_date | borverseny_borid | borverseny_díj |
| -------------------------- | --------------- | ---------------- | -------------- |
| Decanter World Wine Awards | 2023-04-12      | 2                | aranyérem      |
 ### Borvidekek
| borvidekek_id | borvidekek_name | borvidekek_area |
| ------------- | --------------- | --------------- |
| 1             | Bordeaux        | 61700           |
### Borvidekek_Parcellai
| parcellak_borvidekid | parcellak_parcellaid | parcellak_szolotipus | parcellak_szolofajta | parcellak_terulet |
| -------------------- | -------------------- | -------------------- | -------------------- | ----------------- |
| 1                    | 1                    | vörös                | Merlot               | 10000             |
### Bor_Borvidek_Linker
| linker_bor_id | linker_borvidek_id |
| ------------- | ------------------ |
| 2             | 1                  |
### Szolofajtak
| szolofajtak_borid | szolofajtak_szolotipus | szolofajtak_szoloneve |
| ----------------- | ---------------------- | --------------------- |
| 2                 | vörös                  | Merlot                |
 ## Irányelveink adatbázis tervezés és készítése alatt
- Adatintegritás biztosítása
- Az oszlopok ne tartalmazzanak speciális karaktereket amik megzavarhatják esetlegesen az adatbázis kezelőket és lekérdezéseket.
- Az oszlopok nevei beszédesek legyenek és tartalmazzák részben vagy egészben a saját tábláik nevét a könnyebb lekérdezés érdekében.
- A kapcsolatok kialakítása a biztonságosabb adattárolás érdekében.
- A legmegfelelőbb adattípusok kiválasztása adatonként.

# Általános és Gyakori Lekérdezések

- ### Összes bor lekérdezése:
```Sql
SELECT * FROM borok;
```
- ### Borok keresése névalapján
```Sql
SELECT * FROM borok WHERE borok_name LIKE '%kereső kifejezés%';
```
- ### Borok szűrése szőlőfajta alapján:
```Sql
SElECT * FROM borok JOIN Szolofajtak ON borok.borok_id = szolofajtak.szolofajtak_borid WHERE szolofajtak.szolofajtak_szoloneve LIKE '%Merlot%';
```
- ### Adott terület vörösbor százalékos aránya:
```Sql
SELECT CONCAT(ROUND(((SELECT SUM(borvidekek_parcellai.parcellak_terulet) FROM borvidekek JOIN borvidekek_parcellai ON borvidekek.borvidekek_id = borvidekek_parcellai.parcellak_borvidekid WHERE borvidekek.borvidekek_name LIKE "%Tokaj%" AND borvidekek_parcellai.parcellak_szolotipus LIKE "vörös")/borvidekek.borvidekek_area*100),2),"%") as "VOROSSZAZALEK" FROM borvidekek WHERE borvidekek.borvidekek_name LIKE "Tokaj";
```
- ### Bor versenyek keresése névalapján
```Sql
SELECT * FROM borversenyek WHERE borverseny_name LIKE '%kereső kifejezés%';
```
- ### Adott bor versenyeken nyert díjai
```Sql
SELECT borok.borok_name, borversenyek.borverseny_name, borversenyek.borverseny_dij FROM borok Join borversenyek ON borok.borok_id = borversenyek.borverseny_borid WHERE borok.borok_name LIKE "Tokaji Aszú";
```
- ### Aranyérmes borok és adataik
```Sql
SELECT borok.borok_producer,borok.borok_name,borok.borok_vintage,borvidekek.borvidekek_name FROM borversenyek JOIN borok ON borok.borok_id = borversenyek.borverseny_borid JOIN bor_borvidek_linker ON borok.borok_id = bor_borvidek_linker.linker_bor_id JOIN borvidekek ON bor_borvidek_linker.linker_borvidek_id = borvidekek.borvidekek_id WHERE borversenyek.borverseny_dij LIKE "aranyérem";
```
# További funkciók:
- Az adatbázis bővíthető további táblákkal, például a borok értékeléseinek, a vásárlásoknak és a beszállítóknak a tárolására.
- Az adatbázis lekérdezések és jelentések készítésére használható a borokról szóló információk elemzéséhez.
- Az adatbázis integrálható egy webes alkalmazással a borok online kezelésére.
