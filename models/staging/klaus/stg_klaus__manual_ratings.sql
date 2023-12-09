with source as (
  select * from {{ source('klaus', 'manual_ratings') }}
  ),

final as (
  select 
    payment_id,
    team_id,
    review_id,
    category_id,
    rating,
    json_value_array(cause) as cause,
    rating_max,
    weight,
    critical,
    category_name
  from
    source

)

select * from final