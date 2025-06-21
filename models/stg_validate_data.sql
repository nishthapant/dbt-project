with base as (
    select * from {{ ref('stg_cleaned_data')}}
),

validated as (

    select 
        product_id,
        product_name,
        category,
        discounted_price,
        actual_price,
        discount_percentage,
        rating,
        rating_count,
        about_product,
        user_id,
        user_name,
        review_id,
        review_title,
        review_content,
    
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
)

select * from validated