-- {{ config(materialized='table') }}

with base as (
    select * from {{ref('stg_validated_data')}}
),

dim_reviews_metadata as (
    select
        distinct review_id,
        review_title,
        review_content,
        product_id,
        user_id

    from base
)

select * from dim_reviews_metadata