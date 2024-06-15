{{
  config(
    materialized='incremental'
  )
}}
WITH source AS (
    SELECT * FROM {{ ref('intermediate_football_games') }}
),
renamed AS (
    SELECT
        a.game_id,
        e.date_id,
        f.team_id as team_id_home,
        g.team_id as team_id_away,
        b.tournament_id,
        c.country_id,
        d.city_id,
        score_id,
        a.scorer,
        home_score,
        away_score,
        a.tournament,
        a.home_team,
        a.away_team,
        CONCAT(home_team, ' vs ', away_team) as match,
        CONCAT(home_score, '-', away_score) as result,
        CONCAT(a.city, ' (', a.country, ')') as place,
        a.date,
        a._fivetran_synced,
        CONCAT(scorer,' min ',minute,' (',team_score,')') as goal,
        CASE
            WHEN home_score > away_score THEN home_team
            WHEN away_score > home_score THEN away_team
            ELSE 'draw'
        END as winner,
        SUM(home_score + away_score) AS total_goals
    FROM source a 
    INNER JOIN {{ ref('dim_tournament') }} b ON a.tournament_id = b.tournament_id
    INNER JOIN {{ ref('dim_country') }} c ON a.country_id = c.country_id
    INNER JOIN {{ ref('dim_city') }} d ON a.city_id = d.city_id
    INNER JOIN {{ ref('dim_time') }} e ON a.date_id = e.date_id
    INNER JOIN {{ ref('dim_teams') }} f ON a.home_team = f.team
    INNER JOIN {{ ref('dim_teams') }} g ON a.away_team = g.team
    GROUP BY
        1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
    order by a.date DESC
)
SELECT * FROM renamed
{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}