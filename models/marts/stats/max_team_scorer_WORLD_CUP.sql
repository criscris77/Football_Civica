with 

source as (

    select * from {{ ref('fct_games') }}
),

renamed as (
    
    SELECT team_score,COUNT(*) AS NUM_GOLES 
    FROM source
    WHERE TOURNAMENT='FIFA World Cup' 
    GROUP BY team_score
    ORDER BY NUM_GOLES DESC 
    LIMIT 10

)

select * from renamed