with 

source as (

    select * from {{ ref('fct_games') }}
),

renamed as (
    
    SELECT SCORER,COUNT(*) AS NUM_GOLES 
    FROM source
    WHERE TOURNAMENT='FIFA World Cup'
    GROUP BY SCORER
    ORDER BY NUM_GOLES DESC 
    LIMIT 10

)

select * from renamed