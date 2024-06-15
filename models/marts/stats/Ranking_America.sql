WITH tournament_ranking AS (
    {{ ranking_tournament('Copa América') }}
)
SELECT * FROM tournament_ranking