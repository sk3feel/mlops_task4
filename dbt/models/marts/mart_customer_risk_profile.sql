{{ config(materialized='table') }}

select
    name_1,
    name_2,
    lat,
    lon,
    count() as transaction_count,
    countIf(target = 1) as fraud_count,
    min(transaction_time) as first_transaction_time,
    max(transaction_time) as last_transaction_time,
    100.0 * avg(target) as fraud_rate,
    avg(amount) as avg_amount,
    case
        when fraud_rate >= 1 then 'HIGH'
        when fraud_rate >= 0.5 then 'MEDIUM'
        else 'LOW'
    end as risk_level
from {{ ref('stg_transactions') }}
group by name_1, name_2, lat, lon
