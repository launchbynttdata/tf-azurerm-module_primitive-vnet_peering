logical_product_family  = "dso"
logical_product_service = "vnetpeer"

network_map = {
  "vnet1" = {
    vnet_name     = "vnet-test-800"
    address_space = ["10.10.0.0/16"]
    subnets = {
      subnet-1 = {
        prefix = "10.10.0.0/24"
      }
    }
    bgp_community        = null
    ddos_protection_plan = null
    dns_servers          = []
    tags                 = {}
  }
  "vnet2" = {
    vnet_name     = "vnet-test-801"
    address_space = ["10.11.0.0/16"]
    subnets = {
      subnet-1 = {
        prefix = "10.11.0.0/24"
      }
    }
    bgp_community        = null
    ddos_protection_plan = null
    dns_servers          = []
    tags                 = {}
  }
}


tags = {
  provisioner = "Terraform"
  purpose     = "VNET Peering Terratest"
}
