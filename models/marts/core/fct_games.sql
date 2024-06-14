with 

source as (

    select * from {{ ref('intermediate_football_games') }}
),

renamed as (

    select
        game_id,
        date,
        team_id_home,
        team_id_away,
        home_score,
        away_score,
        match,
        result,
        winner,
        tournament,
        tournament_id,
        country_id,
        city_id,
        score_id,
        team_score,
        scorer,
    from source 

)

select * from renamed