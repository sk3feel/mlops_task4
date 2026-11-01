{{ config(materialized='view') }}

select
    toDateTime(transaction_time) as transaction_time,
    trimBoth(merch) as merch,
    trimBoth(cat_id) as cat_id,
    toFloat64(amount) as amount,
    trimBoth(name_1) as name_1,
    trimBoth(name_2) as name_2,
    upper(trimBoth(gender)) as gender,
    trimBoth(street) as street,
    trimBoth(one_city) as one_city,
    upper(trimBoth(us_state)) as us_state,
    trimBoth(post_code) as post_code,
    lat,
    lon,
    population_city,
    trimBoth(jobs) as jobs,
    merchant_lat,
    merchant_lon,
    toUInt8(target) as target,
    toDate(transaction_time) as transaction_date,
    toHour(transaction_time) as transaction_hour,
    {{ dbt_date.day_of_week('transaction_time') }} as day_of_week,
    {{ amount_bucket('amount') }} as amount_bucket
from {{ source('raw', 'transactions') }}
