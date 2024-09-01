include "root" {
  path = find_in_parent_folders()
}

terraform {
    source = "git::https://github.com/Puhhh/terraform-kubernetes-metallb.git?ref=v1.0.0"
}

inputs = {
  helm-custom-values      = true
  helm-custom-values-path = "metallb.yaml"
  ipaddresspool-start     = "172.168.101.100"
  ipaddresspool-end       = "172.168.101.105"
}