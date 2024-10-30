include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-helm-dashboard.git?ref=v1.0.0"
}

inputs = {
  deploy-method = "helm"
}

generate "module" {
  path      = "network.tf"
  if_exists = "overwrite"
  contents  = <<EOF

module "istio-network" {
  source = "github.com/Puhhh/terraform-istio-network"

  tls-name                       = "helm-dashboard"
  server-url                     = "helm-dashboard.kubernetes.local"
  tls-certificate-files          = true
  tls-crt                        = "LS0tL...tLQo="
  tls-key                        = "LS0tL...tLS0K"
  server-svc-name                = "helm-dashboard"
  server-svc-namemespace         = kubernetes_namespace.helm_dashboard_namespace.metadata[0].name
  destination-port               = 8080
}
EOF
}