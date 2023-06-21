# Preamble (see https://tech.davis-hansson.com/p/make/)
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: all
all: clean run

.PHONY: run
run: db_up schema.hcl migrations

.PHONY: clean
clean:
	rm -rf migrations
	rm -f schema.hcl
	docker-compose rm -fs

.PHONY: db_up
db_up:
	docker-compose up -d postgres
	sleep 3

schema.hcl: atlas.hcl
	atlas schema inspect --env local > $@

.PHONY: migrations
migrations:
	atlas migrate diff --env local baseline
