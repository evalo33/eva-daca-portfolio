# Week 3 – SQL JOIN Report

## Eesmärk

Week 3 eesmärk oli õppida ühendama andmeid erinevatest tabelitest SQL JOIN käskude abil.

## 1. INNER JOIN

```sql
SELECT
    s.sale_id,
    s.sale_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.city,
    s.total_price
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
LIMIT 10;
```

### Tulemus

Päring tagastas 10 rida. Nägin müüke koos kliendi nime, linna ja ostusummaga.

### Järeldus

INNER JOIN näitab ainult neid müüke, millel on olemas vastav klient `customers` tabelis.

## 2. LEFT JOIN

```sql
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    s.sale_id,
    s.total_price
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
LIMIT 10;
```

### Tulemus

Päring tagastas 10 rida. Mõnel kliendil olid `sale_id` ja `total_price` väärtused NULL.

### Järeldus

LEFT JOIN näitab kõiki kliente, ka neid, kellel ei ole ostu.

## 3. Kliendid ilma ostudeta

```sql
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.city,
    c.email
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
ORDER BY c.customer_id;
```

### Tulemus

Leiti **599 klienti**, kellel ei ole ühtegi ostu.

### Järeldus

`LEFT JOIN` koos tingimusega `WHERE s.sale_id IS NULL` aitab leida kliendid, kellel puudub vaste `sales` tabelis.

## Kokkuvõte

Week 3 jooksul õppisin kasutama INNER JOIN-i ja LEFT JOIN-i. Sain aru, et JOIN aitab ühendada eri tabelites olevaid andmeid, näiteks müüke ja kliendiandmeid. Kõige olulisem tulemus oli, et UrbanStyle andmebaasis on **599 klienti**, kes ei ole veel ühtegi ostu teinud.