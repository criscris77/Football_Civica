with 

source as (

    select * from {{ source('football_source', 'goalscorers') }}

),

renamed as (

    select
        date,
        home_team,
        away_team,
        team,
        scorer,
        minute,
        own_goal,
        penalty

    from source

)

select * from renamed
