


with source as (
      select * from {{ ref('base_stackoverflow_posts_questions') }}
)

select id from source