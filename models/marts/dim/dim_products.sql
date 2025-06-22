-- {{ config(materialized='table') }}

with base as (
    select
        product_id,
        product_name,
        category,
        about_product,
        actual_price,
        rating_count,
        row_number() over (
            partition by product_id
            order by rating_count desc nulls last
        ) as row_num

    from {{ref('stg_validated_data')}}
    where product_id is not null
),

dim_products as (
    select
        product_id,
        product_name,
        category,
        about_product,
        actual_price,
        rating_count

    from base
    where row_num=1
)

select * from dim_products