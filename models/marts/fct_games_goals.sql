{{ config(
    materialized='incremental',
    unique_key='score_id'
) }}

with source as (
    select * from {{ ref('intermediate_football_games') }}
),

renamed as (
    select
        a.*
    from source a 
    inner join {{ ref('dim_tournament') }} b 
        on a.tournament = b.tournament
    inner join {{ ref('dim_country') }} c 
        on a.country = c.country
    inner join {{ ref('dim_city') }} d 
        on a.city = d.city
    inner join {{ ref('dim_time') }} e
        on a.date = e.date
    inner join {{ ref('dim_teams') }} f
        on a.home_team = f.team
    inner join {{ ref('dim_teams') }} g
        on a.away_team = g.team
)

select * from renamed
{% if is_incremental() %}
    WHERE _fivetran_synced > (SELECT COALESCE(MAX(_fivetran_synced), '1900-01-01') FROM {{ this }} )
{% endif %}
ORDER BY date DESC

