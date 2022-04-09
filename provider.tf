provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      "ManagedByTFE" = "1"
      "Product"      = "CRM_ClientDev"
    }
  }
}
