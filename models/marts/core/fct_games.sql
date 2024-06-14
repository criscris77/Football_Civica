with 

source as (

    select * from {{ ref('intermediate_football_games') }}
),

renamed as (

    select
        game_id,
        date_id,
        team_id_home,
        team_id_away,
        home_score,
        away_score,
        tournament_id,
        country_id,
        city_id,
        score_id,
        match,
        result
    from source 

)

select * from renamed