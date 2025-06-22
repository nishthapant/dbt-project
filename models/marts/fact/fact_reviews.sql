-- {{ config(materialized='table') }}

with base as (
    select * from {{ref('stg_validated_data')}}
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
)

select * from fact_reviews