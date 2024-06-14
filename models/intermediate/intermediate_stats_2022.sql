with 

source as (

    select *  from {{ ref('stg_football__stadistics_2022') }}

),

renamed as (

    select
        *
    from source
   
)

select distinct* from renamed