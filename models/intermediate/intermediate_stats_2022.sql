with 

source as (

    select *  from {{ ref('stg_football__stadistics_2022') }}

),

renamed as (

    select
        city,
        team1,
        team2,
        POSSESSION_TEAM1,
        POSSESSION_TEAM2,
        POSSESSION_IN_CONTEST,
        CONCAT(NUMBER_OF_GOALS_TEAM1, '-', NUMBER_OF_GOALS_TEAM2) as result,
        date,
        hour,
        category,
        YELLOW_CARDS_TEAM1,
        YELLOW_CARDS_TEAM2,
        RED_CARDS_TEAM1,
        RED_CARDS_TEAM2,
        OFFSIDES_TEAM1,
        OFFSIDES_TEAM2,
        PASSES_TEAM1,
        PASSES_TEAM2,
        PASSES_COMPLETED_TEAM1,
        PASSES_COMPLETED_TEAM2,
        CORNERS_TEAM1,
        CORNERS_TEAM2,
        game_id
        
    from source
   
)

select distinct* from renamed