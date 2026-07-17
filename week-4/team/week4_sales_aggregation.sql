-- =========================================================
-- NÄDAL 4 – SQL AGREGATSIOONID
-- Roll A – Müügi koondandmed
-- UrbanStyle Ltd
-- =========================================================


-- =========================================================
-- ÜLESANNE 1 – MÜÜK KUUDE KAUPA
-- Näitab 2024. aasta iga kuu tellimuste arvu,
-- kogukäivet ja keskmist tellimuse väärtust.
-- =========================================================

SELECT
    DATE_TRUNC('month', sale_date)::date AS kuu,
    COUNT(DISTINCT invoice_id) AS tellimuste_arv,
    ROUND(SUM(total_price), 2) AS kogukaive,
    ROUND(
        SUM(total_price)
        / NULLIF(COUNT(DISTINCT invoice_id), 0),
        2
    ) AS keskmine_tellimus
FROM sales
WHERE sale_date >= DATE '2024-01-01'
  AND sale_date < DATE '2025-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;


-- =========================================================
-- ÜLESANNE 2 – MÜÜK KATEGOORIATE KAUPA
-- Ühendab sales ja products tabelid.
-- HAVING jätab alles kategooriad, mille käive ületab 100 000 €.
-- =========================================================

SELECT
    p.category AS kategooria,
    SUM(s.quantity) AS myydud_tooteid,
    COUNT(DISTINCT s.invoice_id) AS tellimuste_arv,
    ROUND(SUM(s.total_price), 2) AS kogukaive,
    ROUND(
        SUM(s.total_price)
        / NULLIF(SUM(s.quantity), 0),
        2
    ) AS keskmine_myygihind
FROM sales s
INNER JOIN products p
    ON s.product_id = p.product_id
WHERE s.sale_date >= DATE '2024-01-01'
  AND s.sale_date < DATE '2025-01-01'
GROUP BY p.category
HAVING SUM(s.total_price) > 100000
ORDER BY kogukaive DESC;


-- =========================================================
-- ÜLESANNE 3 – KUISED TRENDID CTE JA LAG() ABIL
-- Arvutab kuust-kuusse muutuse eurodes ja protsentides.
-- =========================================================

WITH kuu_myyk AS (
    SELECT
        DATE_TRUNC('month', sale_date)::date AS kuu,
        COUNT(DISTINCT invoice_id) AS tellimuste_arv,
        ROUND(SUM(total_price), 2) AS kaive
    FROM sales
    WHERE sale_date >= DATE '2024-01-01'
      AND sale_date < DATE '2025-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
),
trend AS (
    SELECT
        kuu,
        tellimuste_arv,
        kaive,
        LAG(kaive) OVER (ORDER BY kuu) AS eelmine_kuu
    FROM kuu_myyk
)
SELECT
    kuu,
    tellimuste_arv,
    kaive,
    eelmine_kuu,
    ROUND(kaive - eelmine_kuu, 2) AS muutus_eurodes,
    ROUND(
        (kaive - eelmine_kuu)
        / NULLIF(eelmine_kuu, 0) * 100,
        1
    ) AS kasvu_protsent
FROM trend
ORDER BY kuu;


-- =========================================================
-- KONTROLLPÄRING – 2024. AASTA KOGUKÄIVE
-- =========================================================

SELECT
    ROUND(SUM(total_price), 2) AS aasta_kogukaive
FROM sales
WHERE sale_date >= DATE '2024-01-01'
  AND sale_date < DATE '2025-01-01';


-- =========================================================
-- PEAMISED TULEMUSED
-- =========================================================
-- 2024. aasta kogukäive: 1 470 358,02 €
-- Kõrgeim kuukäive: detsember – 170 623,28 €
-- Madalaim kuukäive: jaanuar – 85 618,65 €
-- Suurim kuine kasv: detsember – +54,3%
-- Suurim kuine langus: september – -24,6%
-- Suurima käibega kategooria: meeste riided – 389 738,54 €