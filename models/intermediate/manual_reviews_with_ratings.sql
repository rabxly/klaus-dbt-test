with reviews as (
  select * from {{ ref('stg_klaus__manual_reviews') }}
),

ratings as (
  select * from {{ ref('stg_klaus__manual_ratings') }}
),

category_groups as (
  select * from {{ ref('rating_category_groups') }}
),

reviews_with_ratings as (
  select
    reviews.external_ticket_id,
    review_id,
    created as review_created_at,
    reviews.score as review_score,
    reviews.seen,
    reviews.disputed,
    reviews.assignment_review,
    reviews.reviewer_id,
    reviews.reviewee_id,
    category_id as rating_category_id,
    category_name as rating_category_name,
    rating_category_group
    rating_max,
    rating,
    (rating / rating_max) * 100 as rating_score,
    weight,
    critical
  from reviews 
  inner join ratings using (review_id)
  left join category_groups on category_name=rating_category_name
  where rating <= rating_max)

select * from reviews_with_ratings 