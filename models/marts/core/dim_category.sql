WITH source AS (
    SELECT * FROM {{ ref('stg_football__category') }}
),
renamed AS (
    SELECT
        *
    FROM source 
)

SELECT  *
FROM renamed