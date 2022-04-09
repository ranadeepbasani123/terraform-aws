variable "glue_configurations" {
  type = list(object({
    glue_job = object({
      account           = string
      db                = string
      extra_jars        = string
      iam_role          = string
      number_of_workers = number
      port              = number
      schema            = string
      script_location   = string
      secret            = string
      timeout           = number
      url               = string
      warehouse         = string
      worker_type       = string
    })
    glue_trigger = object({
      schedule = string
      type     = string
    })
    name = string
  }))
}
