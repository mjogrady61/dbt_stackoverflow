


SELECT 
    -- Surrogate key 
     {{ dbt_utils.generate_surrogate_key(["user_id"]) }}        AS surrogate_key_users,
    
    --  business key
       user_id,
   
    --  user info 
       user_display_name,
       user_age,
       user_creation_date,
       user_last_access_date,
       user_location,
       user_reputation,
       user_up_votes,
       user_down_votes,
       user_views,
   
    -- Activity info
       DATE_DIFF(current_date(), user_creation_date, DAY)       AS days_since_user_created,
       DATE_DIFF(current_date(), user_last_access_date, DAY)    AS days_since_user_last_accessed,


FROM {{ ref('stg_stackoverflow__users') }}