with source as (
      select * from {{ source('stackoverflow', 'posts_questions') }}
),
renamed as (
    select
        {{ adapter.quote("id") }},
        {{ adapter.quote("title") }},
        {{ adapter.quote("body") }},
        {{ adapter.quote("accepted_answer_id") }},
        {{ adapter.quote("answer_count") }},
        {{ adapter.quote("comment_count") }},
        {{ adapter.quote("community_owned_date") }},
        {{ adapter.quote("creation_date") }},
        {{ adapter.quote("favorite_count") }},
        {{ adapter.quote("last_activity_date") }},
        {{ adapter.quote("last_edit_date") }},
        {{ adapter.quote("last_editor_display_name") }},
        {{ adapter.quote("last_editor_user_id") }},
        {{ adapter.quote("owner_display_name") }},
        {{ adapter.quote("owner_user_id") }},
        {{ adapter.quote("parent_id") }},
        {{ adapter.quote("post_type_id") }},
        {{ adapter.quote("score") }},
        {{ adapter.quote("tags") }},
        {{ adapter.quote("view_count") }}

    from source
)
select * from renamed
  