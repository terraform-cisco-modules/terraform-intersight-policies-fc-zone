<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-fc-zone/actions/workflows/terratest.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-fc-zone/actions/workflows/terratest.yml)

# Terraform Intersight Policies - FC Zone
Manages Intersight FC Zone Policies

Location in GUI:
`Policies` » `Create Policy` » `FC Zone`

## Easy IMM

[*Easy IMM - Comprehensive Example*](https://github.com/terraform-cisco-modules/easy-imm-comprehensive-example) - A comprehensive example for policies, pools, and profiles.

## Example

### main.tf
```hcl
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
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = fileexists(var.secretkeyfile) ? file(var.secretkeyfile) : var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  default     = ""
  description = "Intersight Secret Key Content."
  sensitive   = true
  type        = string
}

variable "secretkeyfile" {
  default     = "blah.txt"
  description = "Intersight Secret Key File Location."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with the value of [your-api-key]
- Add variable secretkey with the value of [your-secret-file-content]

### Linux and Windows
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkeyfile="<secret-key-file-location>"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_fc_target_zoning_type"></a> [fc\_target\_zoning\_type](#input\_fc\_target\_zoning\_type) | Type of FC zoning. Allowed values are SIST, SIMT and None.<br>* None: (default) - FC zoning is not configured.<br>* SIMT - Single Initiator Multiple Target.  The system automatically creates one zone for each vHBA. Configure this type of zoning if the number of zones created is likely to exceed the maximum supported number of zones.<br>* SIST - Single Initiator Single Target.  The system automatically creates one zone for each vHBA and storage port pair. Each zone has two members. | `string` | `"None"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_targets"></a> [targets](#input\_targets) | A List of FC Target Details to assign to the Policy<br>* name - Name given to the target member.<br>* switch\_id - Unique identifier for the Fabric object.<br>  - A - Switch Identifier of Fabric Interconnect A.<br>  - B - Switch Identifier of Fabric Interconnect B.<br>* vsan\_id - VSAN with scope defined as Storage in the VSAN policy.<br>* wwpn - WWPN that is a member of the FC zone. | <pre>list(object(<br>    {<br>      name      = string<br>      switch_id = string<br>      vsan_id   = number<br>      wwpn      = string<br>    }<br>  ))</pre> | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | FC Zone Policy Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_fabric_fc_zone_policy.fc_zone](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_fc_zone_policy) | resource |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
<!-- END_TF_DOCS -->