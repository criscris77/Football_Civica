with 

source as (

    select * from {{ ref('base__results') }}

),

renamed as (

    select
        *

    from source

)

select * from renamed
