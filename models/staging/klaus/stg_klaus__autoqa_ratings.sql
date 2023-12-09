with source as (
  select * from {{ source('klaus', 'autoqa_ratings') }}
  ),

final as (
  select 
    autoqa_review_id,
    autoqa_rating_id,
    payment_id,
    team_id,
    payment_token_id,
    external_ticket_id,
    rating_category_id,
    rating_category_name,
    rating_scale_score,
    score,
    reviewee_internal_id
  from
    source)

select * from final