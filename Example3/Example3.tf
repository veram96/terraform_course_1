# Output from remote state
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "./../Example2/terraform.tfstate"
   }
}

#Local
locals {
  prefix = "terraform" 
}

# terraform {
#   required_providers {
#     local = {
#       source = "hashicorp/local"
#       version = "~>2.4.0"
#     }
#   }
# }

# provider "local" {
# }

resource "local_file" "file" {
  filename = "${local.prefix}-${var.file_name}"
  # content  = var.file_content
  content  = "vpc_name=${data.terraform_remote_state.vpc.outputs.vpc_name}"
}

# Module
module "create_file" {
  source = "./modules/file_creation"
}

# Variables
variable "file_name" {
  default = "var_default.txt"
  type    = string
}

variable "file_content" {
  default = 5
  type    = number
}

# Outputs
output "file_name"{
  value = local_file.file.filename
}

output "module_file_name"{
  value = module.create_file.file_name
}


