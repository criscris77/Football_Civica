with 

source as (

    select 
        a.game_id,
        a.date,
        a.home_team,
        a.away_team,
        a.home_score,
        a.away_score,
        tournament,
        city,
        country,
        score_id,
        b.team as team_score,
        scorer,
        minute 
        from {{ ref('base__results') }} a 
        inner join {{ ref('base__goalscorers') }} b on
        a.game_id=b.game_id
),

renamed as (

    select
        *
    from source

)

select * from renamed
