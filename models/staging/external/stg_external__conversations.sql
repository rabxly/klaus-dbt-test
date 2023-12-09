with source as (
  select * from {{ source('external', 'conversations') }}
),

final as (
  select
    payment_id,
    payment_token_id,
    external_ticket_id,
    conversation_created_at,
    conversation_created_at_date,
    channel,
    assignee_id, 
    updated_at,
    closed_at,
    message_count,
    last_reply_at,
    language,
    imported_at,
    unique_public_agent_count,
    public_mean_character_count,
    public_mean_word_count,
    private_message_count,
    public_message_count,
    klaus_sentiment,
    is_closed,
    agent_most_public_messages,
    first_response_time,
    first_resolution_time_seconds,
    full_resolution_time_seconds,
    most_active_internal_user_id,
  from source
)

select * from final