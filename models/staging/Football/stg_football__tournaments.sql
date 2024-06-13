with 

source as (

    select distinct tournament  from {{ ref('base__results') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['tournament']) }} as tournament_id,
        tournament
    from source

)

select * from renamed