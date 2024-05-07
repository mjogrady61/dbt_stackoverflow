






SELECT
-- Surrogate Key
    GENERATE_UUID() as fact_question_sk,

--  Business Key
    question_id,

--  Dimension information
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

    -- answered information (from dim_table) 
    is_answered,
    number_of_days_unanswered,
    number_of_days_since_last_activity,
    number_of_days_since_created

    -- Counts and aggregates from the intermediate table
    int_questions_agg.min_answer_date
    int_questions_agg.question_up_votes,
    int_questions_agg.question_down_votes 
    int_questions_agg.accepted_answer_creation_date

    -- Metrics on answered questions (join to stg_answers)

    DATE_DIFF(int_questions_agg.min_answer_date, question_creation_date, DAY) as days_to_first_answer,
    DATE_DIFF(int_questions_agg.accepted_answer_creation_date, question_creation_date, DAY) as days_to_first_answer,

FROM {{ref('dim_questions')}}

LEFT JOIN {{ref('int_join_questions_to_answers_and_votes')}} int_questions_agg