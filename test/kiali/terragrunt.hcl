include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-argocd-kiali.git?ref=v1.0.0"
}

inputs = {
  argocd-token            = "eyJhb...8yY84"
  argocd-server           = "argocd.kubernetes.local:443"
  tls-verify-skip         = true
  helm-custom-values      = true
  helm-custom-values-path = "kiali.yaml"
}


generate "module" {
  path      = "network.tf"
  if_exists = "overwrite"
  contents  = <<EOF

module "istio-network" {
  source = "github.com/Puhhh/terraform-istio-network"

  tls-name                       = "kiali"
  server-url                     = "kiali.kubernetes.local"
  tls-certificate-files          = true
  tls-crt                        = "LS0tL...0tLQo="
  tls-key                        = "LS0tL...tLS0K"
  server-svc-name                = "kiali"
  server-svc-namemespace         = "istio-system"
  destination-port               = 20001
}
EOF
}
