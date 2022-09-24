module "fc_zone_policy" {
  source  = "terraform-cisco-modules/policies-fc-zone/intersight"
  version = ">= 1.0.1"

  description  = "default FC Zone Policy."
  name         = "default"
  organization = "default"
  vsan_list = [
    {
      vsan_id = 100
    }
  ]
}
