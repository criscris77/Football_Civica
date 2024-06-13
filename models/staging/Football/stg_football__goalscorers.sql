with 

source as (

    select * from {{ ref('base__goalscorers') }}

),

renamed as (

    select
        *

    from source

)

select * from renamed
