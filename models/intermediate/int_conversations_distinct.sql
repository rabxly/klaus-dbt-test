with conversations as (
    select * from {{ ref('stg_external__conversations') }}
),

-- We will select the distinct conversations based on the column imported_at, and always use the most up-to-date row
conversations_distinct as (
  select
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
  from
    conversations
  qualify 
        row_number() over(partition by external_ticket_id order by imported_at desc) = 1)

select * from conversations_distinct
