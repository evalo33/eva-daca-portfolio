-- ==========================================
-- Nädal 4 – SQL agregatsioonid
-- Roll A – Müügi analüüs
-- UrbanStyle.ltd
-- ==========================================

-- ==========================================
-- Ülesanne 1 – Müük kuude kaupa (2024)
-- ==========================================
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    COUNT(sale_id) AS tellimuste_arv,
    SUM(total_price) AS kogukaive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= '2024-01-01'
  AND sale_date < '2025-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;

-- ==========================================
-- Ülesanne 1 – Müük kuude kaupa (2024)
-- ==========================================
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    COUNT(sale_id) AS tellimuste_arv,
    SUM(total_price) AS kogukaive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= '2024-01-01'
  AND sale_date < '2025-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;

-- ==========================================
-- Ülesanne 2 – Müük kategooriate kaupa
-- ==========================================
SELECT
    p.category AS kategooria,
    COUNT(DISTINCT p.product_id) AS toodete_arv,
    ROUND(SUM(s.total_price), 2) AS kogumuuk,
    ROUND(AVG(p.retail_price), 2) AS keskmine_hind
FROM products p
INNER JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.total_price) > 300000
ORDER BY kogumuuk DESC;

-- ==========================================
-- Ülesanne 3 – Kuine müügitrend CTE ja LAG abil
-- ==========================================

WITH kuu_myyk AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS kaive
    FROM sales
    WHERE sale_date >= '2024-01-01'
      AND sale_date < '2025-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
    kuu,
    kaive,
    LAG(kaive) OVER (ORDER BY kuu) AS eelmine_kuu,
    kaive - LAG(kaive) OVER (ORDER BY kuu) AS muutus,
    ROUND(
        100.0 * (
            kaive - LAG(kaive) OVER (ORDER BY kuu)
        ) / NULLIF(
            LAG(kaive) OVER (ORDER BY kuu),
            0
        ),
        1
    ) AS kasvu_protsent
FROM kuu_myyk
ORDER BY kuu;