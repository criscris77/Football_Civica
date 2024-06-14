with 

source as (

    select * from {{ ref('intermediate_football_games') }}
),

renamed as (

    select
        * 
    from source 

)

select * from renamed