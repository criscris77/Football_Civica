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
    WHERE date='2010-07-11' and place='Johannesburg (South Africa)'

)

select * from renamed