WITH source AS (
    SELECT * FROM {{ ref('base__stats') }}
),
renamed AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['category']) }} as category_id,
        category
    FROM source 
)

SELECT distinct *
FROM renamed
