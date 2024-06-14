with 

source as (

    select * from {{ ref('fct_games') }}
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