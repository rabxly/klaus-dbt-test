with manual_reviews as (
  select * from {{ ref('int_manual_reviews_with_ratings') }}
),

final as (
  select
    external_ticket_id,
    review_id,
    review_created_at,
    review_score,
    reviewer_id,
    reviewee_id,
    rating_category_id,
    rating_category_name,
    rating_category_group,
    rating_max,
    rating,
    (rating / rating_max) * 100 as rating_score,
    weight,
    critical
  from manual_reviews
)

select * from final