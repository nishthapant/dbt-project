{{ config(materialized='table')}}

with cleaned as (
    select * from {{ ref('stg_cleaned_data')}}
),

stg_validated_data as (
    select *
    from cleaned
    where
        product_id is not null and
        product_name is not null and
        category is not null and
        discount_percentage is not null and discount_percentage >= 0 and discount_percentage <=100 and
        discounted_price is not null and discounted_price >= 0 and
        actual_price is not null and actual_price >= 0 and
        rating is not null and rating >=0 and rating <=5 and
        rating_count is not null and rating_count >=0 and
        user_id is not null and
        user_name is not null and
        review_id is not null
)

select * from stg_validated_data