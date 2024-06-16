{{ config(materialized='table') }}

WITH top_scorers AS (
    {{ calculate_top_goal_scorers('FIFA World Cup') }}
)

SELECT * FROM top_scorers