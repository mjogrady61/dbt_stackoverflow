{{ config(materialized="table") }}


distinct_tag as (

select distinct(split_question_tag) as tag
from {{ref('int_question_tags_split')}}
)

, add_keys as (

SELECT
    GENERATE_UUID() as surrogate_key_tag,
    tag
from distinct_tag
)


SELECT * FROM add_keys