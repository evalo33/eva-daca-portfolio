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

-- ==========================================
-- Kokkuvõte
-- ==========================================
-- 2024. aasta müük kasvas üldiselt aasta jooksul.
-- Suurima kogukäibega kuu oli detsember (170 623,28 €).
-- Väikseima kogukäibega kuu oli jaanuar (85 618,65 €).
-- Suurim kuine kasv toimus detsembris (+54,3%), samas kui suurim langus oli septembris (-24,6%).
-- Juhatusele soovitan kasutada aasta lõpu tugevat hooajalisust kampaaniate ja varude planeerimisel.

-- ==========================================
-- Ülesanne 4 – Turunduskanalite tulemuslikkus
-- ==========================================

WITH puhastatud_logid AS (
    SELECT
        log_id,
        customer_id,
        visit_date,
        CASE
            WHEN LOWER(TRIM(source)) IN (
                'google organic',
                'google_organic'
            ) THEN 'Google Organic'

            WHEN LOWER(TRIM(source)) IN (
                'google',
                'google_ads'
            ) THEN 'Google'

            WHEN LOWER(TRIM(source)) IN (
                'facebook',
                'fb'
            ) THEN 'Facebook'

            WHEN LOWER(TRIM(source)) IN (
                'facebook ads',
                'facebook_ads',
                'fb_ads'
            ) THEN 'Facebook Ads'

            WHEN LOWER(TRIM(source)) IN (
                'instagram',
                'ig'
            ) THEN 'Instagram'

            WHEN LOWER(TRIM(source)) IN (
                'instagram_ads',
                'ig_ads'
            ) THEN 'Instagram Ads'

            WHEN source IS NULL THEN 'Tundmatu kanal'

            ELSE INITCAP(REPLACE(TRIM(source), '_', ' '))
        END AS turunduskanal
    FROM web_logs
    WHERE customer_id IS NOT NULL
),

kliendi_viimane_kanal AS (
    SELECT
        customer_id,
        turunduskanal,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY visit_date DESC, log_id DESC
        ) AS koht
    FROM puhastatud_logid
)

SELECT
    COALESCE(kvk.turunduskanal, 'Tundmatu kanal') AS turunduskanal,
    COUNT(DISTINCT s.customer_id) AS kliente,
    COUNT(DISTINCT s.invoice_id) AS tellimusi,
    ROUND(SUM(s.total_price), 2) AS kogukaive,
    ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
FROM sales s
LEFT JOIN kliendi_viimane_kanal kvk
    ON s.customer_id = kvk.customer_id
   AND kvk.koht = 1
GROUP BY COALESCE(kvk.turunduskanal, 'Tundmatu kanal')
ORDER BY kogukaive DESC;

-- Turunduse kokkuvõte
-- Turunduskanalite nimetused vajasid enne analüüsi ühtlustamist.
-- Igale kliendile määrati tema viimane teadaolev turunduskanal,
-- et sama müüki ei arvestataks mitme veebikülastuse tõttu korduvalt.
-- Kõrgeima kogukäibega kanal selgub puhastatud tulemuste võrdlemisel.
-- Tundmatu kanaliga ostud viitavad vajadusele parandada turundusallika salvestamist.