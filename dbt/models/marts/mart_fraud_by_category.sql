{{ config(materialized='table') }}

select
    cat_id,
    count() as transaction_count,
    countIf(target = 1) as fraud_count,
    100.0 * avg(target) as fraud_rate,
    sum(amount) as total_amount,
    sumIf(amount, target = 1) as fraud_amount
from {{ ref('stg_transactions') }}
group by cat_id
