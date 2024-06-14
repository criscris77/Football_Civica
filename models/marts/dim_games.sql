with 

source as (

    select *  from {{ ref('stg_football__games') }}

),

renamed as (

    select
        *
    from source

)

select * from renamed