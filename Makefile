# Examera Database Management

DB_CONTAINER=db
DB_USER=examera
DB_NAME=examera_db
SCHEMA_FILE=backend/db/schema.sql
SEED_FILE=backend/db/seed.sql

.PHONY: up down schema seed reset help

up: ## Start the database container
	docker compose up -d

down: ## Stop the database container
	docker compose down

schema: ## Apply the database schema
	docker compose exec -T $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME) < $(SCHEMA_FILE)

seed: ## Seed the database with sample data
	docker compose exec -T $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME) < $(SEED_FILE)

reset: down up schema seed ## Reset the database (stop, start, apply schema, and seed)

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
