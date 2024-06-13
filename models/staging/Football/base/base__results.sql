with 

source as (

    select * from {{ source('football_source', 'results') }}

),

renamed as (

    select
        date,
        home_team,
        away_team,
        home_score,
        away_score,
        tournament,
        city,
        country,
        neutral

    from source

)

select * from renamed
