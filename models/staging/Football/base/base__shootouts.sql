with 

source as (

    select * from {{ source('football_source', 'shootouts') }}

),

renamed as (

    select
        date,
        home_team,
        away_team,
        winner,
        first_shooter

    from source

)

select * from renamed
