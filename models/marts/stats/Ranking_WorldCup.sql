WITH tournament_ranking AS (
    {{ ranking_tournament('FIFA World Cup') }}
)
SELECT * FROM tournament_ranking
