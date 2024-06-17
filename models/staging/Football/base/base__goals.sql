{{ config(
    materialized='incremental',
    unique_key='score_id'
) }}
with source as (
    select * from {{ source('football_source', 'goalscorers') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['date','home_team','away_team']) }} as game_id,
        --Hay casos en los que un jugador ha metido dos goles en el mismo minuto por lo que tenemos que darle ids diferentes
        CASE 
            WHEN COUNT(*) OVER(PARTITION BY date, home_team, away_team, scorer, minute) > 1 
            THEN CONCAT({{ dbt_utils.generate_surrogate_key(['date','home_team','away_team','scorer','minute']) }}, '_', ROW_NUMBER() OVER(PARTITION BY date, home_team, away_team, scorer, minute ORDER BY _fivetran_synced)) 
            ELSE {{ dbt_utils.generate_surrogate_key(['date','home_team','away_team','scorer','minute']) }} 
        END as score_id,
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
    WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )
{% endif %}

