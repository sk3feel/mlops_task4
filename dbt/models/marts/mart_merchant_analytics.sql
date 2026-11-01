{{ config(materialized='table') }}

select
    merch,
    sum(amount) as total_amount,
    100.0 * avg(target) as fraud_rate,
    fraud_rate > (
        select 100.0 * avg(stg.target)
        from {{ ref('stg_transactions') }} as stg
    ) as is_suspicious
from {{ ref('stg_transactions') }}
group by merch
