env {
  name = atlas.env
  src  = "./schema.hcl"

  // Define the URL of the database which is managed in
  // this environment.
  url = "postgres://postgres:postgres@0.0.0.0:5432/atlas-repro?sslmode=disable"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  dev = "docker://postgres/15/dev"

  // The schemas in the database that are managed by Atlas.
  schemas = ["beehive"]

  migration {
    dir    = "file://migrations"
    format = atlas
  }
}
