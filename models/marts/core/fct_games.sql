with 

source as (
    select * from {{ ref('intermediate_football_games') }}
),

renamed as (
    select
        game_id,
        a.date,
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
        minute 
    from source a 
    inner join {{ ref('dim_tournament') }} b 
    on a.tournament=b.tournament
    inner join  {{ ref('dim_country') }} c 
    on a.country=c.country
    inner join  {{ ref('dim_city') }} d 
    on a.city=d.city
    inner join {{ ref('dim_time') }} e
    on a.date=e.date
    inner join {{ ref('dim_teams') }} f
    on a.home_team=f.team
    inner join {{ ref('dim_teams') }} g
    on a.away_team=g.team
    
)

select * from renamed