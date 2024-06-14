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
        case
            when first_shooter is null then 'unknown'
            else first_shooter
        end as first_shooter

    from source

)

select * from renamed
