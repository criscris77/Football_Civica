{% macro obtener_estadisticas() %}
    {{ return([
        {"campo1": "YELLOW_CARDS_TEAM1", "campo2": "YELLOW_CARDS_TEAM2", "alias": "total_yellow_cards"},
        {"campo1": "RED_CARDS_TEAM1", "campo2": "RED_CARDS_TEAM2", "alias": "total_red_cards"},
        {"campo1": "CORNERS_TEAM1", "campo2": "CORNERS_TEAM2", "alias": "total_corners"},
        {"campo1": "NUMBER_OF_GOALS_TEAM1", "campo2": "NUMBER_OF_GOALS_TEAM2", "alias": "total_goals"}
    ]) }}
{% endmacro %}



