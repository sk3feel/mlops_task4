{{ config(materialized='table') }}

select
    us_state,
    100.0 * avg(target) as fraud_rate,
    uniqExact(name_1, name_2, lat, lon) as unique_customers,
    uniqExact(merch) as unique_merchants,
    sum(amount) as total_amount,
    sumIf(amount, target = 1) as fraud_amount
from {{ ref('stg_transactions') }}
group by us_state
