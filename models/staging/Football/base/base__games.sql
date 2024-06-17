{{ config(
    materialized='incremental',
    unique_key='game_id'
) }}
with 

source as (

    select * from {{ source('football_source', 'results') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['date','home_team','away_team']) }} as game_id,
        TO_DATE(date) as date,
        home_team,
        away_team,
        CAST(home_score AS NUMBER) AS home_score,
        CAST(away_score AS NUMBER) AS away_score,
        tournament,
        city,
        country,
        _fivetran_synced

    from source
    where tournament in ('Copa América','UEFA Euro','FIFA World Cup') 
)

select * from renamed
{% if is_incremental() %}
    WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )
{% endif %}