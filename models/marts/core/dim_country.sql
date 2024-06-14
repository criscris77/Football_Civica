with 

source as (

    select *  from {{ ref('stg_football__country') }}

),

renamed as (

    select
        *
    from source

)

select * from renamed