{{ config(materialized='table') }}

with base as (
    select * from {{source('raw', 'amazon_review_raw_data')}}
),

stg_cleaned_data as (
    select 
        review_id,
        product_id,
        product_name,
        category,
        safe_cast(discounted_price as float64) as discounted_price,
        safe_cast(actual_price as float64) as actual_price,
        safe_cast(discount_percentage as float64) as discount_percentage,
        safe_cast(rating as float64) as rating,
        safe_cast(rating_count as int64) as rating_count,
        regexp_replace(about_product, r'<[^>]*>','') as about_product,
        regexp_replace(review_title, r'<[^>]*>','') as review_title,
        regexp_replace(review_content, r'<[^>]*>','') as review_content,
        user_id,
        user_name,
        case
            when regexp_contains(img_link, r'^https?://[\w./%-]+$' )
                then img_link
            else null
        end as img_link,

        case
            when regexp_contains(product_link, r'^https?://[\w./%-]+$')
                then product_link
            else null
        end as product_link
    
    from base
    where product_id is not null and
        product_name is not null and
        category is not null and
        discount_percentage is not null and
        discounted_price is not null and
        actual_price is not null and
        rating is not null and
        rating_count is not null and
        user_id is not null and
        user_name is not null and
        review_id is not null
)

select * from stg_cleaned_data


