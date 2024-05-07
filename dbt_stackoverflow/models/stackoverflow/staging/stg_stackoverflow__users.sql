
with source as (

    select * from {{source('stackoverflow','users')}}
)

, renamed as (

    SELECT 
       {{ dbt_utils.generate_surrogate_key(["id"]) }} as surrogate_key_users,
       id                AS user_id,
       display_name      AS user_display_name,
       about_me          AS user_about_me,
       age               AS user_age,
       creation_date     AS user_creation_date,
       last_access_date  AS user_last_access_date,
       location          AS user_location,
       reputation        AS user_reputation,
       up_votes          AS user_up_votes,
       down_votes        AS user_down_votes,
       views             AS user_views,
       profile_image_url AS user_profile_image_url,
       website_url       AS user_website_url
    FROM source
)

SELECT * FROM renamed