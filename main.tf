#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  name = var.organization
}

#_______________________________________________________________________________
#
# FC Zone Policies
# GUI Location: Configure > Policies > Create Policy > FC Zone
#_______________________________________________________________________________

resource "intersight_fabric_fc_zone_policy" "fc_zone" {
  depends_on = [
    data.intersight_organization_organization.org_moid
  ]
  description           = var.description != "" ? var.description : "${var.name} FC Zone Policy."
  fc_target_zoning_type = var.fc_target_zoning_type
  name                  = var.name
  organization {
    moid        = data.intersight_organization_organization.org_moid.results[0].moid
    object_type = "organization.Organization"
  }
  dynamic "fc_target_members" {
    for_each = { for v in var.targets : v.name => v }
    content {
      name      = fc_target_members.key
      switch_id = fc_target_members.value.switch_id
      vsan_id   = fc_target_members.value.vsan_id
      wwpn      = fc_target_members.value.wwpn
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
