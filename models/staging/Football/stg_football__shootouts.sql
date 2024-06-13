with 

source as (

    select * from {{ ref('base__shootouts') }}

),

renamed as (

    select
        *

    from source

)

select * from renamed
