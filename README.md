# Atlas reproduction repo

## Issue
When generating a migration against a `schema.hcl` from an existing database (restored from a `pg_dump` dump) an initial migration is created that drops the `public` schema even though that does not exist in `schema.hcl`.

## Running

Running:

```shell
make
```

Should clean up any pre-generated files then:

- Start a postgres database
- Restore that database to a state mirroring an existing database via a `pg_dump` generated dump
- Generate `schema.hcl` using `atlas schema inspect`
- Generate a migration using `atlas migrate diff`


Note: the SQL files in `initdb.d` are automatically run by the postgres container on startup and `drop_public.sql` ensures the `public` schema does not exist by the time we run `atlas inspect schema`.
