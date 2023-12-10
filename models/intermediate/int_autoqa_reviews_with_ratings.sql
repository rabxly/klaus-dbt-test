with reviews as (
  select * from {{ ref('stg_klaus__autoqa_reviews') }}
),

ratings as (
  select * from {{ ref('stg_klaus__autoqa_ratings') }}
),

root_cause_data as (
  select * from {{ ref('stg_klaus__autoqa_root_cause') }}
),

category_groups as (
  select * from {{ ref('rating_category_groups') }}
),

root_cause_filtered as (
  select autoqa_rating_id, root_cause from root_cause_data where root_cause is not null
),

reviews_with_ratings as (
  select
    reviews.external_ticket_id,
    reviews.autoqa_review_id,
    autoqa_rating_id,
    reviews.created_at as review_created_at,
    reviews.reviewee_internal_id,
    rating_category_id,
    rating_category_name,
    rating_category_group,
    rating_scale_score,
    score,
    root_cause
  from reviews 
  inner join ratings using(autoqa_review_id)
  left join root_cause_filtered using(autoqa_rating_id)
  left join category_groups using(rating_category_name)
)

select * from reviews_with_ratings