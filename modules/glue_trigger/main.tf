resource "aws_glue_trigger" "sandbox_job_trigger" {

  name     = var.name
  schedule = var.schedule
  type     = var.type

  actions {
    job_name = var.job_name
  }
}
