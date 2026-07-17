# Nädal 4 – SQL agregatsioonid

## UrbanStyle Ltd – Müügi koondandmete analüüs

### Projekti eesmärk

Analüüsida UrbanStyle Ltd müügiandmeid SQL agregatsioonifunktsioonide abil ning koostada juhtkonnale ülevaade ettevõtte müügitulemustest.

Minu vastutusalaks oli **Roll A – Müügi koondandmed**.

---

## Kasutatud SQL tehnikad

- GROUP BY
- HAVING
- Common Table Expression (CTE)
- Window Function `LAG()`
- Agregatsioonifunktsioonid `SUM()`, `COUNT()` ja `AVG()`

---

## Minu ülesanded

Lahendasin järgmised analüüsid:

- 2024\. aasta müügikäive kuude lõikes
- Müügikäive kategooriate lõikes
- Kuise müügitrendi analüüs CTE ja LAG() abil
- Juhtkonnale peamiste müügitulemuste kokkuvõtte koostamine

---

## Peamised tulemused

- 2024\. aasta kogukäive oli **1 470 358,02 €**.
- Kõrgeim käive saavutati **detsembris (170 623,28 €)**.
- Madalaim käive oli **jaanuaris (85 618,65 €)**.
- Suurima käibega kategooria olid **meeste riided (389 738,54 €)**.
- Suurim kuine kasv toimus **detsembris (+54,3%)**.
- Suurim müügilangus toimus **septembris (−24,6%)**.

---

## Juhtkonna soovitused

- Keskendada suurem osa turundustegevusest aasta lõpu perioodile.
- Investeerida enim müüki toovatesse kategooriatesse – meeste riided ja jalanõud.
- Analüüsida septembrikuu müügilanguse põhjuseid.
- Arendada väiksema käibega kategooriaid sihipäraste kampaaniate abil.

---

## Õppisin

- kasutama SQL agregatsioonifunktsioone suuremate andmemahtude analüüsimiseks;
- koostama GROUP BY ja HAVING päringuid;
- kasutama CTE ja LAG() funktsioone müügitrendide analüüsimiseks;
- esitama andmeid juhtkonnale arusaadaval ja visuaalsel kujul.

---

## Failid

- `week4_sales_aggregation.sql` – SQL päringud
- Esitlusslaidid – Roll A müügi analüüs