-- 1. INNER JOIN: müük + klient

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

-- 2. LEFT JOIN: kõik kliendid ja nende ostud

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    s.sale_id,
    s.total_price
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
LIMIT 10;

-- 3. Kliendid, kellel pole ühtegi ostu

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