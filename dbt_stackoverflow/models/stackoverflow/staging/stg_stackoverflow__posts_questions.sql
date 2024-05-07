


with source as (
      select * from {{ ref('base_stackoverflow_posts_questions') }}
)

, renamed as (
SELECT
       id                                                      AS question_id,
       title                                                   AS question_title,
       body                                                    AS question_body,
       accepted_answer_id                                      AS question_accepted_answer_id,
       answer_count                                            AS question_answer_count,
       comment_count                                           AS question_comment_count,
       EXTRACT(DATE FROM community_owned_date)                 AS question_community_owned_date,
       EXTRACT(DATE FROM creation_date)                        AS question_creation_date,
       COALESCE(favorite_count,0)                              AS question_favorite_count,
       EXTRACT(DATE FROM last_activity_date)                   AS question_last_activity_date,
       EXTRACT(DATE FROM last_edit_date)                       AS question_last_edit_date,
       last_editor_display_name                                AS question_last_edit_display_name,
       last_editor_user_id                                     AS question_last_editor_user_id,
       owner_display_name                                      AS question_owner_display_name,
       owner_user_id                                           AS question_owner_user_id,
       score                                                   AS question_score,
       tags                                                    AS question_tags,
       view_count                                              AS question_view_count,
       
FROM source
)


SELECT * FROM renamed