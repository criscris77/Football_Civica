{{ config(materialized='table') }}

WITH top_scorers AS (
    {{ calculate_top_goal_scorers('Copa América') }}
)

SELECT * FROM top_scorers