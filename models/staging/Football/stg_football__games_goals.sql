{{ config(
    materialized='incremental',
    unique_key='score_id'
) }}
with 

source as (

    select 
        a.game_id,
        score_id,
        a.date,
        a.home_team,
        a.away_team,
        a.home_score,
        a.away_score,
        tournament,
        city,
        country,
        b.team as team_score,
        scorer,
        minute ,
        a._fivetran_synced
        from {{ ref('base__games') }} a 
        inner join {{ ref('base__goals') }} b on
        a.game_id=b.game_id
),

renamed as (

    select
        *
    from source

)

select * from renamed
{% if is_incremental() %}
    WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )
{% endif %}