-- {{ config(materialized='table') }}

with base as (
    select 
        review_id,
        product_id,
        actual_price,
        discount_percentage,
        discounted_price,
        rating,
        user_id,
        row_number() over (
            partition by review_id
            order by rating desc nulls last
        ) as row_num
    
    from {{ref('stg_validated_data')}}
    where review_id is not null
),

fact_reviews as (
    select
        review_id,
        product_id,
        actual_price,
        discount_percentage,
        discounted_price,
        rating,
        user_id
    
    from base
    where row_num=1
)

select * from fact_reviews