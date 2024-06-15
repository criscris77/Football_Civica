{{
  config(
    materialized='incremental'
  )
}}
with 

source as (

    select * from {{ source('football_source', 'goalscorers') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['date','home_team','away_team']) }} as game_id,
        {{ dbt_utils.generate_surrogate_key(['date','home_team','away_team','scorer','minute']) }} as score_id,
        date,
        home_team,
        away_team,
        team,
        scorer,
        CAST(minute as Number) as minute,
        _fivetran_synced
    from source
)

select * from renamed
{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}