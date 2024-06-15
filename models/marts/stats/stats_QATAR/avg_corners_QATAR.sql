WITH source AS (
    SELECT * 
    FROM {{ ref('fct_stats') }}
),

renamed AS (
    SELECT 
        team1 AS team, 
        CORNERS_TEAM1 AS corners
    FROM source

    UNION ALL

    SELECT 
        team2 AS team, 
        CORNERS_TEAM2 AS corners
    FROM source
),

averaged AS (
    SELECT 
        team, 
        ROUND(AVG(corners),2) AS avg_corners
    FROM renamed
    GROUP BY team
)

SELECT * 
FROM averaged
ORDER BY avg_corners DESC 
LIMIT 10
