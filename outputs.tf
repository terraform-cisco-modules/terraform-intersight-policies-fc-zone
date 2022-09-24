#____________________________________________________________
#
# Collect the moid of the FC Zone Policy
#____________________________________________________________

output "moid" {
  description = "FC Zone Policy Managed Object ID (moid)."
  value       = intersight_fabric_fc_zone_policy.fc_zone.moid
}
