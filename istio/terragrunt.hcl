include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-istio.git?ref=v1.0.3"
}

inputs = {
  helm-custom-values = true
  helm-custom-values-path = {
    istio-base         = "istio-base.yaml"
    istiod             = "istiod.yaml"
    istio-ingress      = "istio-ingress.yaml"
    peerauthentication = "peerauthentication.yaml"
    istio-gateway      = "istio-gateway.yaml"
  }
  helm-chart-version = {
    istio           = "1.23.1"
    custom-manifest = "0.0.1"
  }
  istio-ingress-gateway = true
  use-istio-cni         = true
}