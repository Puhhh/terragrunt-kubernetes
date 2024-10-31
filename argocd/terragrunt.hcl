include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-argocd.git?ref=v1.0.3"
}

inputs = {
  helm-custom-values      = true
  helm-custom-values-path = "argocd.yaml"
  helm-chart-version      = "7.5.2"
  argocd-host             = "argocd.kubernetes.local"
  configmap-name          = "kubernetes-local"
}

generate "module" {
  path      = "network.tf"
  if_exists = "overwrite"
  contents  = <<EOF

module "istio-network" {
  source = "github.com/Puhhh/terraform-istio-network?ref=v1.0.1"

  tls-name                       = "argocd"
  server-url                     = "argocd.kubernetes.local"
  tls-certificate-files          = true
  tls-crt                        = "LS0tL...tLQo="
  tls-key                        = "LS0tL...tLS0K"
  server-svc-name                = "argocd-server"
  server-svc-namemespace         = kubernetes_namespace.argocd-namespace.metadata[0].name
  destination-port               = 80
}
EOF
}