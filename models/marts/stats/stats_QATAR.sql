{% set estadisticas = obtener_estadisticas() %}

WITH source AS (
    SELECT * 
    FROM {{ ref('fct_stats') }}
),

renamed AS (
    SELECT
        city,
        team1,
        team2,
        POSSESSION_TEAM1,
        POSSESSION_TEAM2,
        POSSESSION_IN_CONTEST,
        CONCAT(NUMBER_OF_GOALS_TEAM1, '-', NUMBER_OF_GOALS_TEAM2) AS result,
        date,
        hour,
        category,
        YELLOW_CARDS_TEAM1,
        YELLOW_CARDS_TEAM2,
        RED_CARDS_TEAM1,
        RED_CARDS_TEAM2,
        OFFSIDES_TEAM1,
        OFFSIDES_TEAM2,
        PASSES_TEAM1,
        PASSES_TEAM2,
        PASSES_COMPLETED_TEAM1,
        PASSES_COMPLETED_TEAM2,
        CORNERS_TEAM1,
        CORNERS_TEAM2,
        NUMBER_OF_GOALS_TEAM1,
        NUMBER_OF_GOALS_TEAM2,
        game_id
    FROM source
),

filtered AS (
    SELECT
        city,
        team1,
        team2,
        result,
        date,
        hour,
        category,
        {% for stat in estadisticas %}
            SUM({{ stat.campo1 }} + {{ stat.campo2 }}) AS {{ stat.alias }}{% if not loop.last %}, {% endif %}
        {% endfor %}
    FROM renamed
    WHERE category IN ('Round of 16', 'Quarter-final', 'Semi-final', 'Final')
    GROUP BY
        city,
        team1,
        team2,
        result,
        date,
        hour,
        category
    ORDER BY date DESC
)

SELECT * FROM filtered

