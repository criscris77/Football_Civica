with 

source as (

    select *  from {{ ref('intermediate_stats_2022') }}

),

renamed as (

    select
        *
    from source
   
)

select distinct* from renamed