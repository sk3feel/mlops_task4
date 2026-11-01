CREATE DATABASE IF NOT EXISTS transactions_db;

CREATE TABLE IF NOT EXISTS transactions_db.transactions (
    transaction_time DateTime,
    merch String,
    cat_id String,
    amount Float64,
    name_1 String,
    name_2 String,
    gender String,
    street String,
    one_city String,
    us_state String,
    post_code String,
    lat Float64,
    lon Float64,
    population_city UInt32,
    jobs String,
    merchant_lat Float64,
    merchant_lon Float64,
    target UInt8
)
ENGINE = MergeTree
ORDER BY tuple();

CREATE TABLE IF NOT EXISTS transactions_db.transactions_kafka AS transactions_db.transactions
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'transactions',
    kafka_group_name = 'clickhouse_hw4',
    kafka_format = 'JSONEachRow',
    date_time_input_format = 'best_effort';

CREATE MATERIALIZED VIEW IF NOT EXISTS transactions_db.transactions_mv
TO transactions_db.transactions AS
SELECT * FROM transactions_db.transactions_kafka;
