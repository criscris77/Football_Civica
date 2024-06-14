with 

source as (

    select *  from {{ ref('stg_football__time') }}

),

renamed as (

    select
        *
    from source

)

select * from renamed