// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "network_map" {
  description = "Map of spoke networks where vnet name is key, and value is object containing attributes to create a network"
  type = map(object({
    resource_group_name = optional(string)
    location            = optional(string)
    vnet_name           = optional(string)
    address_space       = optional(list(string), ["10.0.0.0/16"])
    subnets = map(object({
      prefix = string
      delegation = optional(map(object({
        service_name    = string
        service_actions = list(string)
      })), {})
      service_endpoints                             = optional(list(string), []),
      private_endpoint_network_policies_enabled     = optional(bool, false)
      private_link_service_network_policies_enabled = optional(bool, false)
      network_security_group_id                     = optional(string, null)
      route_table_id                                = optional(string, null)
    }))
    bgp_community = optional(string, null)
    ddos_protection_plan = optional(object(
      {
        enable = bool
        id     = string
      }
    ), null)
    dns_servers      = optional(list(string), [])
    nsg_ids          = optional(map(string), {})
    route_tables_ids = optional(map(string), {})
    tags             = optional(map(string), {})
  }))
}

//variables required by resource names module
variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
    region     = optional(string, "eastus2")
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 80
      region     = "eastus"
    }
    vpc_peering = {
      name       = "peer"
      max_length = 80
      region     = "eastus"
    }
  }
}

variable "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  type        = string
  default     = "dev"
}

variable "environment_number" {
  description = "The environment count for the respective environment. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "001"
}

variable "resource_number" {
  description = "The resource count for the respective resource. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "001"
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "network"
}

variable "tags" {
  type    = map(string)
  default = {}
}
