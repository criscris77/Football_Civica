{{ config(
    materialized='incremental',
    unique_key='score_id'
) }}

with source as (
    select * from {{ ref('intermediate_football_games') }}
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

