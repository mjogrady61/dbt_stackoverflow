


WITH grouped_tags as (

    SELECT 
        GENERATE_UUID() AS surrogate_key_tags,
        question_id,
        question_tags
    FROM {{ref('stg_stackoverflow__posts_questions')}}

)


, split_tags as (

    SELECT
        surrogate_key_tags,
        question_id,
        split_question_tag
    from grouped_tags, UNNEST(SPLIT(question_tags,'|')) AS split_question_tag
)

-- This can act as a bridging table between questions and tags (topics) so we can build fact tables to analyse the tags and how active they are on SO

select * from split_tags

