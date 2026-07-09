# Week 2 – SQL Cleaning Report

## Autor
Eva

## Eesmärk

Week 2 eesmärk oli kontrollida UrbanStyle andmebaasi kvaliteeti ning leida duplikaadid ja võimalikud andmeprobleemid.

## Testkoopia

Lõin testtabeli:

```sql
CREATE TABLE sales_test AS
SELECT * FROM sales;
```

Kontrollisin ridade arvu:

```sql
SELECT COUNT(*) AS ridade_arv
FROM sales_test;
```

**Tulemus:** 15 234 rida.

## Duplikaatide analüüs

Kasutatud päring:

```sql
SELECT invoice_id,
       COUNT(*) AS koopiate_arv
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
```

### Tulemused

- Leiti **4013** duplikaatset `invoice_id`.
- Enamik arveid kordus **2 korda**.
- Mõned kordusid **3, 4 või 5 korda**.
- Kõige suurem korduste arv oli **6**, selliseid arveid oli **2**.

### Kokkuvõte

- Kokku ridu tabelis: **15 234**
- Duplikaatseid `invoice_id`: **4013**
- Üleliigseid duplikaatseid ridu: **5116**

Järeldus: andmestikus on märkimisväärne hulk duplikaate ning enne analüüsi tuleks need puhastada.

## NULL väärtuste kontroll

Kasutatud päring:

```sql
SELECT
    COUNT(*) AS kliente_kokku,
    COUNT(email) AS email_olemas,
    COUNT(*) - COUNT(email) AS email_puudub,
    COUNT(phone) AS telefon_olemas,
    COUNT(*) - COUNT(phone) AS telefon_puudub
FROM customers;
```

### Tulemused

| Väli | Tulemus |
|------|---------|
| Kliente kokku | 3150 |
| E-mail olemas | 2770 |
| E-mail puudub | 380 |
| Telefon olemas | 3150 |
| Telefon puudub | 0 |

### Järeldus

Andmestikus puudub 380 kliendi e-posti aadress, kuid kõigil klientidel on telefoninumber olemas. Analüüsi tegemisel tuleb arvestada, et e-posti põhjal ei saa kõiki kliente kaasata.

## Kokkuvõte

Week 2 jooksul õppisin:

- looma testtabeli (`sales_test`);
- leidma duplikaate (`GROUP BY`, `HAVING`);
- arvutama üleliigseid duplikaatseid ridu;
- kontrollima NULL-väärtusi SQL päringutega.

Sain aru, et enne andmete analüüsimist tuleb alati kontrollida andmete kvaliteeti, sest duplikaadid ja puuduvad väärtused võivad analüüsi tulemusi mõjutada.