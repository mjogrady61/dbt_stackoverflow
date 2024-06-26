{{ config(materialized="table") }}

WITH int_tag_model as 
    (
SELECT
    *
FROM {{ref('int_question_tags_split')}}

    )

, tag_agg as (
SELECT 
    split_question_tag,
    count(*) as tag_count
FROM int_tag_model
)

-- This should be an intermediate model, but moving here for now
, questions_joined_to_tags
    (
SELECT 
    int_tag_model.question_id,
    questions.* except(question_id)
FROM int_tag_model

LEFT JOIN {{ref('stg_stackoverflow__posts_questions')}} questions
    )


SELECT 
    surrogate_key_tag,
    tag as tag_name,
    count(*) as tag_count,
    -- placeholder for count of accepted answers
    -- placeholder for upvotes and downvotes in the last 6 months
    -- placeholder for answer in the last 6 months
    -- count(case when questions_joined_to_tags.qu)
FROM {{ref('dim_tag')}} dim_tag

