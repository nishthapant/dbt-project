with base as (
    select  review_id,
        review_title,
        review_content,
        product_id,
        user_id,
        row_number() over (
            partition by review_id
            order by review_title nulls last
        ) as row_num
        from {{ref('stg_validated_data')}}
        where review_id is not null
),

dim_reviews_metadata as (
    select
        review_id,
        review_title,
        review_content,
        product_id,
        user_id
    from base
    where row_num=1
)

select * from dim_reviews_metadata