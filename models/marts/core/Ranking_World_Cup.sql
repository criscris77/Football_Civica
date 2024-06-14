with 

source as (
    select * from {{ ref('fct_games') }}
),

renamed as (
    
    select
        tournament,
        home_team as team,
        case
            when home_score > away_score then 3
            when home_score = away_score then 1
            else 0
        end as points
    from source
    WHERE tournament='FIFA World Cup'
    union all
    select
        tournament,
        away_team as team,
        case
            when away_score > home_score then 3
            when away_score = home_score then 1
            else 0
        end as points
    from source
    WHERE tournament='FIFA World Cup'
)

    select
        tournament,
        team,
        sum(points) as total_points
    from renamed
    group by tournament, team
    order by tournament, total_points desc
    limit 10