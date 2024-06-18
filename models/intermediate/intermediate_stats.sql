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
    INNER JOIN {{ ref('stg_football__teams') }} b 
    ON a.TEAM1 = UPPER(b.team)
    INNER JOIN {{ ref('stg_football__teams') }} c 
    ON a.TEAM2 = UPPER(c.team)
    INNER JOIN {{ ref('stg_football__time') }} d
    ON a.date = d.date
    INNER JOIN {{ ref('stg_football__category') }} e
    ON a.category = e.category
    INNER JOIN {{ ref('stg_football__city') }} f
    ON a.city = f.city
    INNER JOIN {{ ref('stg_football__country') }} g
    ON a.country = g.country
    INNER JOIN {{ ref('stg_football__tournaments') }} h
    ON a.tournament = h.tournament
   
)

select * from renamed