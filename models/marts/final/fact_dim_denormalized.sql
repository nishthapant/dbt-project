with fact as (
    select * from {{ ref('fact_reviews') }}
),
products as (
    select * from {{ ref('dim_products') }}
),
review_meta as (
    select * from {{ ref('dim_reviews_metadata') }}
),
users as (
    select * from {{ ref('dim_users') }}
),

fact_dim_denormalized as (
    select
        ft.review_id,
        ft.product_id,
        pd.product_name,
        pd.category,
        pd.actual_price,
        ft.discount_percentage,
        ft.discounted_price,
        ft.rating,
        ft.user_id,
        us.user_name,
        rm.review_title,
        rm.review_content
    from fact ft
    left join products pd on ft.product_id = pd.product_id
    left join users us on ft.user_id = us.user_id
    left join review_meta rm on ft.review_id = rm.review_id
)

select * from fact_dim_denormalized