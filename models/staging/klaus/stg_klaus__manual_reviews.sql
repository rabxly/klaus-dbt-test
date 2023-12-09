with source as (
  select * from {{ source('klaus', 'manual_reviews') }}
  ),

final as (
  select 
    imported_at,
    cast(review_time_seconds as float64) as review_time_seconds,
    disputed,
    seen,
    scorecard_tag,
    comment_id,
    conversation_created_date,
    team_id,
    assignment_review,
    reviewer_id,
    conversation_external_id as external_ticket_id,
    updated_by,
    scorecard_id,
    reviewee_id,
    assignment_name,
    conversation_created_at,
    payment_token_id,
    payment_id,
    created,
    updated_at,
    score,
    review_id
  from
    source

)

select * from final