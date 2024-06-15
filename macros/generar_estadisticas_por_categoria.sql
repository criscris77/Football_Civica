{% macro generar_estadisticas_por_categoria() %}
    {% set estadisticas = [
        {"campo1": "YELLOW_CARDS_TEAM1", "campo2": "YELLOW_CARDS_TEAM2", "alias": "total_yellow_cards"},
        {"campo1": "RED_CARDS_TEAM1", "campo2": "RED_CARDS_TEAM2", "alias": "total_red_cards"},
        {"campo1": "CORNERS_TEAM1", "campo2": "CORNERS_TEAM2", "alias": "total_corners"},
        {"campo1": "NUMBER_OF_GOALS_TEAM1", "campo2": "NUMBER_OF_GOALS_TEAM2", "alias": "total_goals"}
    ] %}
    
    WITH estadisticas_por_categoria AS (
        {% for categoria in ['Round of 16', 'Quarter-final', 'Semi-final', 'Final'] %}
            SELECT
                city,
                team1,
                team2,
                CONCAT(NUMBER_OF_GOALS_TEAM1, '-', NUMBER_OF_GOALS_TEAM2) AS result,
                date,
                hour,
                category,
                {% for stat in estadisticas %}
                    SUM({{ stat['campo1'] }} + {{ stat['campo2'] }}) AS {{ stat['alias'] }}{% if not loop.last %}, {% endif %}
                {% endfor %}
            FROM {{ ref('stg_football__stadistics_2022') }}
            WHERE category = '{{ categoria }}'
            GROUP BY city, team1, team2, result, date, hour, category
            
            {% if not loop.last %}
                UNION ALL
            {% endif %}
        {% endfor %}
    )
    
    SELECT * FROM estadisticas_por_categoria
{% endmacro %}
