with 

source as (

    select home_team as team from {{ ref('base__games') }}
    where tournament in ('Copa América','UEFA Euro','FIFA World Cup')
    union
    select away_team as team from {{ ref('base__games') }}
    where tournament in ('Copa América','UEFA Euro','FIFA World Cup')
)

-- Eliminar duplicados
, distinct_teams as (
    select distinct team from source
)

-- Asignar IDs únicos a los equipos
select
    {{ dbt_utils.generate_surrogate_key(['team']) }} as team_id,
    team
from distinct_teams


