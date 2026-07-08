-- Week 1 - SQL Basics

-- 1. Vaata kõiki müüke
SELECT *
FROM sales
LIMIT 5;

-- 2. Vali vajalikud veerud
SELECT sale_id, customer_id, total_price
FROM sales;

-- 3. Suured müügid
SELECT sale_id, customer_id, total_price
FROM sales
WHERE total_price > 500
ORDER BY total_price DESC;

-- 4. 2024. aasta müügid
SELECT sale_id, sale_date, total_price
FROM sales
WHERE sale_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY sale_date;

-- 5. NULL väärtused
SELECT sale_id, customer_id, total_price
FROM sales
WHERE customer_id IS NULL;

-- 6. Erinevad makseviisid
SELECT DISTINCT payment_method
FROM sales;

-- 7. Unikaalsed kliendid
SELECT COUNT(DISTINCT customer_id)
FROM sales;

-- 8. Duplikaatide leidmine
SELECT sale_id,
       COUNT(*) AS mitu_korda
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1
ORDER BY mitu_korda DESC;