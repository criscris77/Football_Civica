with 

source as (

    select * from {{ source('football_source', 'stadistics_2022') }}

),

renamed as (

    select
        team1,
        team2,
        possession_team1,
        possession_team2,
        possession_in_contest,
        number_of_goals_team1,
        number_of_goals_team2,
        -- Convertir fecha al formato DD/MM/YYYY
        CONCAT(
            SUBSTRING(date, 1, 2), 
            '/',
            CASE
                WHEN SUBSTRING(date, 4, 3) = 'JAN' THEN '01'
                WHEN SUBSTRING(date, 4, 3) = 'FEB' THEN '02'
                WHEN SUBSTRING(date, 4, 3) = 'MAR' THEN '03'
                WHEN SUBSTRING(date, 4, 3) = 'APR' THEN '04'
                WHEN SUBSTRING(date, 4, 3) = 'MAY' THEN '05'
                WHEN SUBSTRING(date, 4, 3) = 'JUN' THEN '06'
                WHEN SUBSTRING(date, 4, 3) = 'JUL' THEN '07'
                WHEN SUBSTRING(date, 4, 3) = 'AUG' THEN '08'
                WHEN SUBSTRING(date, 4, 3) = 'SEP' THEN '09'
                WHEN SUBSTRING(date, 4, 3) = 'OCT' THEN '10'
                WHEN SUBSTRING(date, 4, 3) = 'NOV' THEN '11'
                WHEN SUBSTRING(date, 4, 3) = 'DEC' THEN '12'
            END,
            '/',
            SUBSTRING(date, -4)
        ) AS date,
        hour,
        category,
        total_attempts_team1,
        total_attempts_team2,
        conceded_team1,
        conceded_team2,
        goal_inside_the_penalty_area_team1,
        goal_inside_the_penalty_area_team2,
        goal_outside_the_penalty_area_team1,
        goal_outside_the_penalty_area_team2,
        assists_team1,
        assists_team2,
        on_target_attempts_team1,
        on_target_attempts_team2,
        off_target_attempts_team1,
        off_target_attempts_team2,
        attempts_inside_the_penalty_area_team1,
        attempts_inside_the_penalty_area__team2,
        attempts_outside_the_penalty_area__team1,
        attempts_outside_the_penalty_area__team2,
        left_channel_team1,
        left_channel_team2,
        left_inside_channel_team1,
        left_inside_channel_team2,
        central_channel_team1,
        central_channel_team2,
        right_inside_channel_team1,
        right_inside_channel_team2,
        right_channel_team1,
        right_channel_team2,
        total_offers_to_receive_team1,
        total_offers_to_receive_team2,
        inbehind_offers_to_receive_team1,
        inbehind_offers_to_receive_team2,
        inbetween_offers_to_receive_team1,
        inbetween_offers_to_receive_team2,
        infront_offers_to_receive_team1,
        infront_offers_to_receive_team2,
        receptions_between_midfield_and_defensive_lines_team1,
        receptions_between_midfield_and_defensive_lines_team2,
        attempted_line_breaks_team1,
        attempted_line_breaks_team2,
        completed_line_breaksteam1,
        completed_line_breaks_team2,
        attempted_defensive_line_breaks_team1,
        attempted_defensive_line_breaks_team2,
        completed_defensive_line_breaksteam1,
        completed_defensive_line_breaks_team2,
        yellow_cards_team1,
        yellow_cards_team2,
        red_cards_team1,
        red_cards_team2,
        fouls_against_team1,
        fouls_against_team2,
        offsides_team1,
        offsides_team2,
        passes_team1,
        passes_team2,
        passes_completed_team1,
        passes_completed_team2,
        crosses_team1,
        crosses_team2,
        crosses_completed_team1,
        crosses_completed_team2,
        switches_of_play_completed_team1,
        switches_of_play_completed_team2,
        corners_team1,
        corners_team2,
        free_kicks_team1,
        free_kicks_team2,
        penalties_scored_team1,
        penalties_scored_team2,
        goal_preventions_team1,
        goal_preventions_team2,
        own_goals_team1,
        own_goals_team2,
        forced_turnovers_team1,
        forced_turnovers_team2,
        defensive_pressures_applied_team1,
        defensive_pressures_applied_team2

    from source

)

select * from renamed
