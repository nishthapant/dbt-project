-- {{ config(materialized='table') }}

with base as (
    select * from {{ref('stg_validated_data')}}
),

dim_products as (
    select
        distinct product_id,
        product_name,
        category,
        about_product,
        actual_price,
        rating_count,

    from base
)

select * from dim_products