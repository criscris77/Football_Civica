WITH source AS (
    SELECT * FROM {{ ref('base__stadistics_2022') }}
),
renamed AS (
    SELECT
        a.*,
        b.game_id,
        b.tournament,
        b.city,
        b.country,
        ROW_NUMBER() OVER (PARTITION BY a.team1, a.team2 ORDER BY b.date) AS rn
    FROM source a 
    INNER JOIN {{ ref('stg_football__results') }} b 
        ON a.date=b.date 
)

SELECT * 
FROM renamed
WHERE rn = 1 
order by date

