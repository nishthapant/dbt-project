-- {{ config(materialized='table') }}

with base as (
    select * from {{ref('stg_validated_data')}}
),

dim_users as (
    select
        distinct user_id,
        user_name
    from base
)

select * from dim_users