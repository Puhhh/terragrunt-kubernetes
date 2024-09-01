include "root" {
  path = find_in_parent_folders()
}

terraform {
    source = "git::https://github.com/Puhhh/terraform-kubernetes-local-path-provisioner.git?ref=v1.0.0"
}

inputs = {
  helm-custom-values      = true
  helm-custom-values-path = "local-path-provisioner.yaml"
}