WITH source AS (
    SELECT * 
    FROM {{ ref('fct_stats_FIFAWorldCup_QATAR_2022') }}
),

renamed AS (
    SELECT 
        team1 AS team, 
        SUM(RED_CARDS_TEAM1) AS reds
    FROM source
    GROUP BY team1

    UNION ALL

    SELECT 
        team2 AS team, 
        SUM(RED_CARDS_TEAM2) AS reds
    FROM source
    GROUP BY team2
),

summed AS (
    SELECT 
        team, 
        SUM(reds) AS total_reds
    FROM renamed
    GROUP BY team
)

SELECT * 
FROM summed
ORDER BY total_reds DESC 
LIMIT 10