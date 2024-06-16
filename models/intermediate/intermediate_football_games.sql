with 

source as (
    select * from {{ ref('stg_football__games_goals') }}
),

renamed as (
    select
        game_id,
        e.date_id,
        a.home_team,
        f.team_id as team_id_home,
        a.away_team,
        g.team_id as team_id_away,
        a.home_score,
        a.away_score,
        CONCAT(home_team, ' vs ', away_team) as match,
        CONCAT(home_score, '-', away_score) as result,
        case
            when home_score > away_score then home_team
            when away_score > home_score then away_team
            else 'draw'
        end as winner,
        a.date,
        a.tournament,
        b.tournament_id,
        a.country,
        c.country_id,
        a.city,
        d.city_id,
        CONCAT(a.city, ' (', a.country, ')') as place,
        score_id,
        team_score,
        scorer,
        minute ,
        a._fivetran_synced
    from source a 
    inner join {{ ref('stg_football__tournaments') }} b 
    on a.tournament=b.tournament
    inner join  {{ ref('stg_football__country') }} c 
    on a.country=c.country
    inner join  {{ ref('stg_football__city') }} d 
    on a.city=d.city
    inner join {{ ref('stg_football__time') }} e
    on a.date=e.date
    inner join {{ ref('stg_football__teams') }} f
    on a.home_team=f.team
    inner join {{ ref('stg_football__teams') }} g
    on a.away_team=g.team
    
)

select * from renamed
