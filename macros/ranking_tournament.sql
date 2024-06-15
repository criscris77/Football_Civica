{% macro ranking_tournament(tournament_name) %}
WITH source AS (
    SELECT * FROM {{ ref('fct_games_goals') }}
),
renamed AS (
    SELECT
        tournament,
        home_team AS team,
        CASE
            WHEN home_score > away_score THEN 3
            WHEN home_score = away_score THEN 1
            ELSE 0
        END AS points
    FROM source
    WHERE tournament = '{{ tournament_name }}'
    
    UNION ALL
    
    SELECT
        tournament,
        away_team AS team,
        CASE
            WHEN away_score > home_score THEN 3
            WHEN away_score = home_score THEN 1
            ELSE 0
        END AS points
    FROM source
    WHERE tournament = '{{ tournament_name }}'
)
SELECT
    tournament,
    team,
    SUM(points) AS total_points
FROM renamed
GROUP BY tournament, team
ORDER BY tournament, total_points DESC
LIMIT 10
{% endmacro %}
