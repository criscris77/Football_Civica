with 

source as (

    select distinct city from {{ ref('base__results') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['city']) }} as city_id,
        city
    from source

)

select * from renamed