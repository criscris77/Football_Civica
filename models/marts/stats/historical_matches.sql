with 

source as (

    select * from {{ ref('fct_games_goals') }}
),

renamed as (
    
    SELECT 
        date,
        match,
        result,
        TOURNAMENT,
        place,
        goal
    FROM source
    group by 1,2,3,4,5,6
    order by date DESC

)

select * from renamed