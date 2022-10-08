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
