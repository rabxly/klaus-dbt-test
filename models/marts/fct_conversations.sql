with conversations as (
  select * from {{ ref('int_conversations_distinct') }}
),

auto_reviews as (
  select * from {{ ref('int_autoqa_reviews_with_ratings') }}
),

manual_reviews as (
  select * from {{ ref('int_manual_reviews_with_ratings') }}
),


auto_reviews_agg as (
  select
    external_ticket_id,
    true as has_auto_review,
    count(distinct autoqa_review_id) as total_auto_reviews,
    count(distinct rating_category_group) as number_of_categories_rated_auto,
    avg(score) as avg_score_auto
  from auto_reviews
  where score is not null
  group by external_ticket_id
),

manual_reviews_agg as (
  select
    external_ticket_id,
    true as has_manual_review,
    count(distinct review_id) as total_manual_reviews,
    count(distinct rating_category_group) as number_of_categories_rated_manual,
    avg(review_score) as avg_score_manual
  from manual_reviews
  group by external_ticket_id
),


final as (
  select
    external_ticket_id,
    conversation_created_at_date,
    assignee_id,
    message_count,
    klaus_sentiment,
    full_resolution_time_seconds,
    coalesce(has_auto_review, false) as has_auto_review,
    coalesce(has_manual_review, false) as has_manual_review,
    total_auto_reviews,
    number_of_categories_rated_auto,
    avg_score_auto,
    total_manual_reviews,
    number_of_categories_rated_manual,
    avg_score_manual
  from conversations
  left join auto_reviews_agg using(external_ticket_id)
  left join manual_reviews_agg using(external_ticket_id)
)

select * from final