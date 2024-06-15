with 

source as (

    select distinct country from {{ ref('base__games') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['country']) }} as country_id,
        country
    from source

)

select * from renamed