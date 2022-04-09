# The configuration for the `remote` backend.
terraform {
  backend "remote" {
    organization = "CT-CRM-CLIENTDEV"

    workspaces {
      name = "CRM_CLIENTDEV-GITHUB-ACTIONS"
    }
  }
}

module "glue_jobs" {
  source = "./modules/glue_job"

  for_each = toset(var.glue_configurations)

  account           = each.value.glue_job.account
  db                = each.value.glue_job.db
  extra_jars        = each.value.glue_job.extra_jars
  iam_role          = each.value.glue_job.iam_role
  name              = each.value.name
  number_of_workers = each.value.glue_job.number_of_workers
  port              = each.value.glue_job.port
  schema            = each.value.glue_job.schema
  script_location   = each.value.glue_job.script_location
  secret            = each.value.glue_job.secret
  timeout           = each.value.glue_job.timeout
  url               = each.value.glue_job.url
  warehouse         = each.value.glue_job.warehouse
  worker_type       = each.value.glue_job.worker_type
}

module "glue_job_triggers" {
  source = "./modules/glue_trigger"

  for_each = toset(var.glue_configurations)

  job_name = module.glue_jobs[index(var.glue_configurations, each.key)].glue_job_name
  name     = each.value.name
  schedule = each.value.glue_trigger.schedule
  type     = each.value.glue_trigger.type
}
