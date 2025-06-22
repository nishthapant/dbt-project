with cleaned as (
    select * from {{ ref('stg_cleaned_data')}}
),

stg_validated_data as (
    select *
    from cleaned
    where
        discount_percentage >= 0 and discount_percentage <=100 and
        discounted_price >= 0 and
        actual_price >= 0 and
        rating >=0 and rating <=5 and
        rating_count >=0
)

select * from stg_validated_data