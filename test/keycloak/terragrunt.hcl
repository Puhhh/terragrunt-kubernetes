include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-argocd-keycloak.git?ref=v1.0.0"
}

inputs = {
  argocd-token            = "eyJhb...9XTg0"
  argocd-server           = "argocd.kubernetes.local:443"
  tls-verify-skip         = true
  helm-custom-values      = true
  helm-custom-values-path = "keycloak.yaml"
  configmap-name          = "kubernetes-local"
  admin-username          = "admin"
  admin-password          = "admin"
  proxy-type              = "edge"
}


generate "module" {
  path      = "network.tf"
  if_exists = "overwrite"
  contents  = <<EOF

module "istio-network" {
  source = "github.com/Puhhh/terraform-istio-network"

  tls-name                       = "keycloak"
  server-url                     = "keycloak.kubernetes.local"
  tls-certificate-files          = true
  tls-crt                        = "LS0tL...tCg=="
  tls-key                        = "LS0tL...tLS0K"
  server-svc-name                = "keycloak"
  server-svc-namemespace         = "keycloak"
  destination-port               = 80
}
EOF
}