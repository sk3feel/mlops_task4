COMPOSE = docker compose -p hw4 -f solution/docker-compose.yml
DBT = $(COMPOSE) run --rm dbt

.PHONY: up build load deps run test lint docs docs-serve

up:
	$(COMPOSE) up -d --wait kafka clickhouse

build:
	$(COMPOSE) build producer dbt

load:
	$(COMPOSE) run --rm producer

deps:
	$(DBT) deps

run:
	$(DBT) run

test:
	$(DBT) test

lint:
	$(COMPOSE) run --rm --entrypoint sqlfluff dbt lint .

docs:
	$(DBT) docs generate

docs-serve:
	$(COMPOSE) run --rm -p 8082:8080 dbt docs serve --host 0.0.0.0 --port 8080
