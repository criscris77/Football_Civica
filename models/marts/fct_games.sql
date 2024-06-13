with 

source as (

    select * from {{ ref('base__results') }} a 
    inner join {{ ref('base__goalscorers') }} b on
    a.game_id=b.game_id
),

renamed as (

    select
        --game_id,
        --date,
        --CONCAT(home_team,' vs ',away_team) as match,
        --CONCAT(home_score,'-',away_score) as result,
        tournament,
        --CONCAT(city,'(',country,')') as place,
        score_id,
        team as team_score,
        scorer,
        minute
    from source

)

select * from renamed