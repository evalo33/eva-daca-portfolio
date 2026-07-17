# Nädal 4 – SQL agregatsioonid

## Grupitöö

Nädala eesmärk oli kasutada SQL agregatsioonifunktsioone, et analüüsida UrbanStyle Ltd müügiandmeid ja koostada juhtkonnale ülevaade.

## Minu roll

Minu vastutusalaks oli **Roll A – müügi koondandmed**.

Detailsem kirjeldus, SQL-päringud ja tulemused asuvad kaustas `team/`.

## Minu õpikogemus

Õppisin kasutama SQL-i agregeerimisfunktsioone ja koostama kokkuvõtteid müügiandmete põhjal. Harjutasin `GROUP BY`, `HAVING`, CTE ja `LAG()` kasutamist ning õppisin analüüsima müügikäivet kuude ja tootekategooriate lõikes.

Kõige keerulisem oli valida tellimuste loendamiseks õige väli. Sain aru, et `COUNT(DISTINCT invoice_id)` annab õige tellimuste arvu, sest üks tellimus võib sisaldada mitut müügirida.

Samuti õppisin kontrollima SQL-päringute tulemusi, et veenduda nende korrektsuses, ning koostama analüüsi põhjal lühikesi ärilisi järeldusi.