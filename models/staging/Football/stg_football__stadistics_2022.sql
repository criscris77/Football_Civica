with 

source as (

    select * from {{ ref('base__stadistics_2022') }}

),

renamed as (

    select
        *
        

    from source

)

select * from renamed
