terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
}

# Setup provider, variables and outputs
provider "intersight" {
  apikey    = var.intersight_keyid
  secretkey = file(var.intersight_secretkeyfile)
  endpoint  = var.intersight_endpoint
}

variable "intersight_keyid" {}
variable "intersight_secretkeyfile" {}
variable "intersight_endpoint" {
  default = "intersight.com"
}
variable "name" {}

output "moid" {
  value = module.main.moid
}

# This is the module under test
module "main" {
  source                = "../.."
  description           = "${var.name} FC Zone Policy."
  fc_target_zoning_type = "SIMT"
  name                  = var.name
  organization          = "terratest"
  targets = [
    {
      name      = "storage-array"
      switch_id = "A"
      vsan_id   = 100
      wwpn      = "50:00:00:25:B5:0A:00:00"
    }
  ]
}
