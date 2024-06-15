with 

source as (

    select *  from {{ ref('stg_football__stats') }}

),

renamed as (

    select
        *
    from source
   
)

select distinct* from renamed