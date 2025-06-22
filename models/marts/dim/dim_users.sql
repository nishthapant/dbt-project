with base as (
    select
        user_id,
        user_name,
        row_number() over (
            partition by user_id
            order by user_name nulls last
        ) as row_num
    from {{ref('stg_validated_data')}}
    where user_id is not null
),

dim_users as (
    select
        user_id,
        user_name
    from base
    where row_num=1
)

select * from dim_users