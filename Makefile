#!/bin/bash
SHELL=/bin/bash -o pipefail
export
export COMPOSE_PROJECT_NAME=todo-list
PLATFORM := $(shell uname -s)
IS_MAC := $(shell [[ $(PLATFORM) =~ ^Darwin ]] && echo true)

export COMPOSE_FILE=.docker/local/docker-compose.yml:.docker/local/docker-compose.local.yml:.docker/local/docker-compose.traefik.yml
COMPOSE_COMMAND := docker-compose
APP_EXEC := $(COMPOSE_COMMAND) exec app entrypoint.sh exec

build:
ifeq ("$(IS_MAC)", "true")
	$(COMPOSE_COMMAND) build
else
	$(COMPOSE_COMMAND) build --build-arg USER_ID=$(shell id -u) --build-arg GROUP_ID=$(shell id -g)
endif

start:
	$(COMPOSE_COMMAND) up -d --force-recreate --remove-orphans
	make logs

stop:
	$(COMPOSE_COMMAND) down

logs:
	$(COMPOSE_COMMAND) logs -f

exec:
	$(APP_EXEC)

exec-debug:
	$(APP_DEBUG_EXEC)

migration-diff:
	$(APP_EXEC) bin/console doctrine:migrations:diff

migrate:
	$(APP_EXEC) bin/console doctrine:migrations:migrate

migrate-prev:
	$(APP_EXEC) bin/console doctrine:migrations:migrate prev

async:
	$(APP_EXEC) bin/console messenger:consume async -vv
