with 

source as (

    select *  from {{ ref('intermediate_stats') }}

),

renamed as (

    select
        *
    from source 
   
   
)

select * from renamed