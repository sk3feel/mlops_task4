{{ config(materialized='table') }}

select
    day_of_week,
    transaction_hour,
    count() as transaction_count,
    countIf(target = 1) as fraud_count,
    100.0 * avg(target) as fraud_rate,
    fraud_rate > (
        select 100.0 * avg(stg.target)
        from {{ ref('stg_transactions') }} as stg
    ) as is_high_risk
from {{ ref('stg_transactions') }}
group by day_of_week, transaction_hour
