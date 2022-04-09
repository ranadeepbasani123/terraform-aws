# TERRAFORM

Terraform is one of the most used tools which allow management infrastructure as code. That means declaring infrastructure components in configuration files that are then used by Terraform to provision, adjust and tear down infrastructure in various cloud providers (AWS, Azure, GCP etc.,). Terraform offers a great way to package and reuse common code in the form of modules. Modules simplify projects by increasing readability and allowing teams to organize infrastructure in logical blocks. Terraform helps in making the deployment process automated, it’ll be significantly faster. An automated process will be more consistent, more repeatable, and not prone to manual error. The terraform files can be stored in version control, which means the entire history of the infrastructure is now captured in the commit log.

> More About Terraform for AWS provider

AWS offers many services, below are few listed:
 - LAMBDA: AWS Lambda is a serverless, event-driven compute service that lets you run code for virtually any type of application or backend service without provisioning or managing servers.

 - S3: Amazon Simple Storage Service (Amazon S3) is an object storage service offering industry-leading scalability, data availability, security, and performance. Customers of all sizes and industries can store and protect any amount of data for virtually any use case, such as data lakes, cloud-native applications, and mobile apps.

 - GLUE: AWS Glue is a serverless data integration service that makes it easy to discover, prepare, and combine data for analytics, machine learning, and application development. AWS Glue provides all the capabilities needed for data integration so that you can start analyzing your data and putting it to use in minutes instead of months.

 - SNS: Amazon Simple Notification Service (Amazon SNS) is a fully managed messaging service for both application-to-application (A2A) and application-to-person (A2P) communication.

 - SQS: Amazon Simple Queue Service (SQS) is a fully managed message queuing service that enables you to decouple and scale microservices, distributed systems, and serverless applications. SQS eliminates the complexity and overhead associated with managing and operating message-oriented middleware, and empowers developers to focus on differentiating work. Using SQS, you can send, store, and receive messages between software components at any volume, without losing messages or requiring other services to be available

and there are many other services provided by AWS.

## Project

In this project we use the above mentioned AWS services to build an ........ with an automated deployment using Terraform

## Project Structure

```
- modules
    - glue_job
        - main.tf
        - outputs.tf
        - variables.tf
    - glue_trigger
        - main.tf
        - outputs.tf
        - variables.tf
    - s3
        - main.tf
        - outputs.tf
        - variables.tf
    - lambda
        - main.tf
        - outputs.tf
        - variables.tf
    - sns
        - main.tf
        - outputs.tf
        - variables.tf
    - sqs
        - main.tf
        - outputs.tf
        - variables.tf
- .gitignore
- main.tf
- outputs.tf
- provider.tf
- README.md
- terraform.tfvars
- variables.tf
- terraform.auto.tfvars
```

## Module glue_job details

```
- Inputs
    - role_arn
    - name
    - script_location
    - number_of_workers
    - worker_type
    - timeout
    - extra_jars
    - schema
    - url
    - warehouse
    - port
    - db
    - secret
    - account
- Outputs
    - name
- Resources
    - aws_glue_job
```

## Module glue_trigger details

```
- Inputs
    - schedule
    - type
    - name
    - job_name
- Outputs
    - NONE
- Resources
    - aws_glue_trigger
```

## Module glue_trigger details

```
- Inputs
    - schedule
    - type
    - name
    - job_name
- Outputs
    - NONE
- Resources
    - aws_glue_trigger
```

## Module s3 details

```
- Inputs
    - bucket
- Outputs
    - bucket
- Resources
    - aws_s3_bucket
```

## Module lambda details

```
- Inputs
    - function_name
    - s3_bucket
    - s3_key
    - s3_object_version
    - runtime
    - handler
    - role
    - memory_size
    - timeout
    - publish
- Outputs
    - NONE
- Resources
    - aws_lambda_function
```

## Module sns details

```
- Inputs
    - 
- Outputs
    - 
- Resources
    - 
```

## Module sqs details

```
- Inputs
    - 
- Outputs
    - 
- Resources
    - 
```

----

## provider.tf file in the root folder

> Provide the provider details along with default tags

```terraform

provider "aws" {
    region="us-west-2"
    default_tags {
        tags = {
            "ManagedByTFE" = "1"
            "Product"      = "CRM_ClientDev"
        }
  }    
}

```

----

## variables.tf file in the root folder

> All the variables required will be declared here

```terraform

variable "sample_variable"{
    description = "description of this variable"
    type        = string // --> type
    default     = "default value" // --> default value for this varibale in case if there is no input passed
}

```

----

## terraform.auto.tfvars file in the root folder

> All the input for the variables can be passed here 

----

## main.tf file in the root folder

> Track the lock file remotely

```terraform

terraform {
  backend "remote" {
    organization = "CT-CRM-CLIENTDEV"

    workspaces {
      name = "CRM_CLIENTDEV-GITHUB-ACTIONS"
    }
  }
}

```

> Instantiate the modules by using for_each to deploy multiple times.

```terraform

module "glue_job" {
    source = "./modules/glue_job"

    for_each = var.jobs_list

    name = each.value

    ...
}

module "glue_trigger" {
    source = "./modules/glue_trigger"

    for_each = var.jobs_list

    name     = each.value
    job_name = module.glue_jobs[each.key].name
    ...
}

module "s3" {
    source = "./modules/s3"

    ...
}

module "lambda" {
    source = "./modules/lambda"

    ...
}

module "sns" {
    source = "./modules/sns"

    ...
}

module "sqs" {
    source = "./modules/sqs"

    ...
}

```

----

## outputs.tf file in the root folder

> Data to be returned on completion

```terraform

output "conn_name" {
  value = "${module.glue_connection.name}"
}

```