with source as (
  select * from {{ source('klaus', 'autoqa_root_cause') }}),

filtered as (
  select 
    autoqa_rating_id,
    category,
    count,
    root_cause
  from
    source
  where
    autoqa_rating_id is not null
)

select * from filtered