{{ config(materialized='table') }}

WITH top_scorers AS (
    {{ calculate_top_goal_scorers('UEFA Euro') }}
)

SELECT * FROM top_scorers