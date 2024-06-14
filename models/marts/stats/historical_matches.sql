with 

source as (

    select * from {{ ref('intermediate_football_games') }}
),

renamed as (
    
    SELECT 
        date,
        match,
        result,
        TOURNAMENT,
        place,
        SCORER,
        minute
    FROM source

)

select * from renamed