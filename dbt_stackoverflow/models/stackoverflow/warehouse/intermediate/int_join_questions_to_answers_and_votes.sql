
WITH answers as (
    SELECT * FROM {{ref('stg_stackoverflow__posts_answers')}}
)

, min_answer_date as (

SELECT 
    question_id,
    MIN(answer_creation_date) as min_answer_date
from answers
GROUP BY 1

)

, accepted_answer_info as (
    SELECT
        answer_id,
        answer_creation_date as accepted_answer_creation_date
    FROM answers
)

,votes AS
(SELECT post_id,
        number_of_up_votes AS question_up_votes,
        number_of_down_votes AS question_down_votes
FROM {{ ref('int_group_votes_by_post') }}
)


SELECT 
    questions.question_id,
    
    min_answer_date.min_answer_date,
    accepted_answer_info.accepted_answer_creation_date,
    votes.question_up_votes,
    votes.question_down_votes

FROM {{ref('stg_stackoverflow__posts_questions')}} questions

LEFT JOIN min_answer_date on questions.question_id = min_answer_date.question_id
LEFT JOIN accepted_answer_info on questions.question_accepted_answer_id = accepted_answer_info.answer_id
LEFT JOIN votes on questions.question_id = votes.post_id
