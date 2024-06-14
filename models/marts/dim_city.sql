with 

source as (

    select *  from {{ ref('stg_football__city') }}

),

renamed as (

    select
        *
    from source

)

select * from renamed