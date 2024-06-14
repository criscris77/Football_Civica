with 

source as (

    select *  from {{ ref('stg_football__tournaments') }}

),

renamed as (

    select
        *
    from source

)

select * from renamed