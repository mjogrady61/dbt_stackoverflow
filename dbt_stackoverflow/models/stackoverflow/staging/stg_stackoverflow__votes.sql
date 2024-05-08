
{{ config(materialized="ephemeral") }}



SELECT id AS vote_id,
       creation_date,
       post_id,
       vote_type_id
FROM {{ source('stackoverflow', 'votes') }} AS votes