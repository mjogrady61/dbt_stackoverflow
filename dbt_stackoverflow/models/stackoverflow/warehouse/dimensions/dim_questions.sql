{{ config(materialized="table") }}



WITH base as (

SELECT  
    *
FROM {{ref('stg_stackoverflow__posts_questions')}}

)

, transform as (

SELECT    
    question_id,
    question_title,
    question_body,
    question_accepted_answer_id,
    question_answer_count,
    question_comment_count,
    question_community_owned_date,
    question_creation_date,
    question_favorite_count,
    question_last_activity_date,
    question_last_edit_date,
    question_last_edit_display_name,
    question_last_editor_user_id,
    question_owner_display_name,
    question_owner_user_id,
    question_score,
    question_tags,
    question_view_count,
CASE
    WHEN question_accepted_answer_id is NULL AND (question_answer_count = 0 OR question_answer_count IS NULL) THEN FALSE
    ELSE TRUE
    END                                                          AS is_answered,
-- Table was last update in November 2022, so using this date to reflect latest possible time, rather than using the current_date() function
CASE
    WHEN question_accepted_answer_id is NULL THEN DATE_DIFF(DATE('2022-11-20'), DATE(question_creation_date), DAY)
    ELSE NULL
    END                                                          AS number_of_days_unanswered,
DATE_DIFF(DATE('2022-11-20'), DATE(question_creation_date), DAY) AS number_of_days_since_last_activity,
DATE_DIFF(DATE('2022-11-20'), DATE(question_creation_date), DAY) AS number_of_days_since_created

from base
)

select * from transform