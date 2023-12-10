with auto_reviews as (
  select * from {{ ref('int_autoqa_reviews_with_ratings') }}
),

final as (
  select
    external_ticket_id,
    autoqa_review_id,
    autoqa_rating_id,
    review_created_at,
    reviewee_internal_id,
    rating_category_id,
    rating_category_name,
    rating_category_group,
    rating_scale_score,
    score,
    root_cause
  from auto_reviews
)

select * from final