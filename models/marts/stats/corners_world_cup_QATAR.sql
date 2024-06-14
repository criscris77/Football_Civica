WITH source AS (
    SELECT * 
    FROM {{ ref('fct_stats_FIFAWorldCup_QATAR_2022') }}
),

renamed AS (
    SELECT 
        team1 AS team, 
        SUM((CORNERS_TEAM1)) AS CORNERS
    FROM source
    GROUP BY team1

    UNION ALL

    SELECT 
        team2 AS team, 
        SUM(CORNERS_TEAM2) AS CORNERS
    FROM source
    GROUP BY team2
),

summed AS (
    SELECT 
        team, 
        SUM(CORNERS) AS total_CORNERS
    FROM renamed
    GROUP BY team
)

SELECT * 
FROM summed
ORDER BY total_CORNERS DESC 
LIMIT 10