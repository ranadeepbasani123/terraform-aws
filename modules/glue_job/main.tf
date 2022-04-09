resource "aws_glue_job" "sandbox_job" {

  name              = var.name
  number_of_workers = var.number_of_workers
  role_arn          = var.role_arn
  timeout           = var.timeout
  worker_type       = var.worker_type

  command {
    script_location = var.script_location
  }

  default_arguments = {
    "--ACCOUNT"    = var.account
    "--DB"         = var.db
    "--extra-jars" = var.extra_jars
    "--PORT"       = var.port
    "--SCHEMA"     = var.schema
    "--SECRET"     = var.secret
    "--URL"        = var.url
    "--WAREHOUSE"  = var.warehouse
  }
}
