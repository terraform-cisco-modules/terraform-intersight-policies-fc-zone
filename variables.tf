#_________________________________________________________________________
#
# FC Zone Policies
# GUI Location: Configure > Policies > Create Policy > FC Zone
#_________________________________________________________________________

variable "description" {
  default     = ""
  description = "Description for the Policy."
  type        = string
}

variable "fc_target_zoning_type" {
  default     = "None"
  description = <<-EOT
    Type of FC zoning. Allowed values are SIST, SIMT and None.
    * None: (default) - FC zoning is not configured.
    * SIMT - Single Initiator Multiple Target.  The system automatically creates one zone for each vHBA. Configure this type of zoning if the number of zones created is likely to exceed the maximum supported number of zones.
    * SIST - Single Initiator Single Target.  The system automatically creates one zone for each vHBA and storage port pair. Each zone has two members.
  EOT
  type        = string
}

variable "name" {
  default     = "default"
  description = "Name for the Policy."
  type        = string
}

variable "organization" {
  default     = "default"
  description = "Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/."
  type        = string
}

variable "tags" {
  default     = []
  description = "List of Tag Attributes to Assign to the Policy."
  type        = list(map(string))
}

variable "targets" {
  default     = []
  description = <<-EOT
    A List of FC Target Details to assign to the Policy
    * name - Name given to the target member.
    * switch_id - Unique identifier for the Fabric object.
      - A - Switch Identifier of Fabric Interconnect A.
      - B - Switch Identifier of Fabric Interconnect B.
    * vsan_id - VSAN with scope defined as Storage in the VSAN policy.
    * wwpn - WWPN that is a member of the FC zone.
  EOT
  type = list(object(
    {
      name      = string
      switch_id = string
      vsan_id   = number
      wwpn      = string
    }
  ))
}
