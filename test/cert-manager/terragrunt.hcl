include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-cert-manager.git?ref=v1.0.1"
}

inputs = {
  helm-custom-values      = true
  helm-custom-values-path = "cert-manager.yaml"
  helm-chart-version      = "1.15.3"
}