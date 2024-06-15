{% macro calculate_top_goal_scorers(tournament) %}
WITH source AS (
    SELECT * FROM {{ ref('fct_games_goals') }}
)
SELECT
    SCORER,
    COUNT(*) AS NUM_GOALS 
FROM source
WHERE TOURNAMENT = '{{ tournament }}'
GROUP BY SCORER
ORDER BY NUM_GOALS DESC 
LIMIT 10
{% endmacro %}