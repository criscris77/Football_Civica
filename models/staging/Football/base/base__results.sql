with 

source as (

    select * from {{ source('football_source', 'results') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['date','home_team','away_team']) }} as game_id,
        date,
        home_team,
        away_team,
        home_score,
        away_score,
        tournament,
        city,
        country
    from source
    where tournament in ('Copa América','UEFA Euro','FIFA World Cup')
)

select * from renamed
