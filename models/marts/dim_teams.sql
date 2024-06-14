with 

source as (

    select *  from {{ ref('stg_football__teams') }}

),

renamed as (

    select
        *
    from source

)

select * from renamed