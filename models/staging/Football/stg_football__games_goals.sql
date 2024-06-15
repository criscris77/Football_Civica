{{
  config(
    materialized='incremental'
  )
}}
with 

source as (

    select 
        a.game_id,
        a.date,
        a.home_team,
        a.away_team,
        a.home_score,
        a.away_score,
        tournament,
        city,
        country,
        score_id,
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

  where _fivetran_synced >= (select max(_fivetran_synced) from {{ this }})

{% endif %}