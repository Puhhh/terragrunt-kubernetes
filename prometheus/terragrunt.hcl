include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-prometheus.git?ref=v1.0.1"
}

inputs = {
  helm-custom-values      = true
  helm-custom-values-path = "prometheus.yaml"
}
