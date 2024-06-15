with 

source as (

    select *  from {{ ref('stg_football__stats') }}

),

renamed as (

    select
        b.team_id as team_id_home,
        c.team_id as team_id_away,
        d.date_id,
        e.category_id,
        f.city_id,
        g.country_id,
        h.tournament_id,
        a.*
    from source a
    INNER JOIN {{ ref('dim_teams') }} b 
    ON a.TEAM1 = UPPER(b.team)
    INNER JOIN {{ ref('dim_teams') }} c 
    ON a.TEAM2 = UPPER(c.team)
    INNER JOIN {{ ref('dim_time') }} d
    ON a.date = d.date
    INNER JOIN {{ ref('dim_category') }} e
    ON a.category = e.category
    INNER JOIN {{ ref('dim_city') }} f
    ON a.city = f.city
    INNER JOIN {{ ref('dim_country') }} g
    ON a.country = g.country
    INNER JOIN {{ ref('dim_tournament') }} h
    ON a.tournament = h.tournament
   
)

select * from renamed