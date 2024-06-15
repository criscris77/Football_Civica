WITH source AS (
    SELECT * FROM {{ ref('base__stats') }}
),
renamed AS (
    SELECT
        b.game_id,
        a.*,
        b.tournament,
        b.city,
        b.country,
        ROW_NUMBER() OVER (PARTITION BY a.team1, a.team2 ORDER BY b.date) AS rn
    FROM source a 
    INNER JOIN {{ ref('base__games') }} b 
        ON a.date=b.date 
)

SELECT * 
FROM renamed
WHERE rn = 1 
order by date

