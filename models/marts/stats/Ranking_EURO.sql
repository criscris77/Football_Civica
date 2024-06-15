WITH tournament_ranking AS (
    {{ ranking_tournament('UEFA Euro') }}
)
SELECT * FROM tournament_ranking