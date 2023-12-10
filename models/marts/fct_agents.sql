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
    reviewee_internal_id as assignee_id,
    count(distinct autoqa_review_id) as total_auto_reviews,
    count(distinct rating_category_group) as number_of_categories_rated_auto,
    avg(score) as avg_score_auto
  from auto_reviews
  where score is not null
  group by reviewee_internal_id
),

manual_reviews_agg as (
  select
    reviewee_id as assignee_id,
    count(distinct review_id) as total_manual_reviews,
    count(distinct rating_category_group) as number_of_categories_rated_manual,
    avg(review_score) as avg_score_manual
  from manual_reviews
  group by reviewee_id
),

manual_reviews_given_agg as (
  select
    reviewer_id,
    count(distinct review_id) as total_manual_reviews_given,
  from manual_reviews
  group by reviewer_id
),

agents_agg as (
  select
    assignee_id,
    count(distinct external_ticket_id) as total_conversation_count,
    min(conversation_created_at) as first_conversation_ts,
    max(conversation_created_at) as last_conversation_ts,
    avg(full_resolution_time_seconds / 3600) as avg_full_resolution_time_hours
  from conversations
  group by assignee_id
),

final as (
  select
    assignee_id,
    total_conversation_count,
    first_conversation_ts,
    last_conversation_ts,
    avg_full_resolution_time_hours,
    total_auto_reviews,
    number_of_categories_rated_auto,
    avg_score_auto,
    total_manual_reviews,
    number_of_categories_rated_manual,
    avg_score_manual,
    total_manual_reviews_given
  from agents_agg
  left join auto_reviews_agg using(assignee_id)
  left join manual_reviews_agg using(assignee_id)
  left join manual_reviews_given_agg on assignee_id=reviewer_id
  
)

select * from final