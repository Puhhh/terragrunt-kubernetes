include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-kiali.git?ref=v1.0.4"

  after_hook "apply_patch" {
    commands = ["apply"]
    execute  = ["kubectl", "patch", "virtualservice", "kiali", "-n", "istio-system", "--type=json", "-p=[{\"op\": \"add\", \"path\": \"/spec/http/0/headers\", \"value\": {\"request\": {\"set\": {\"X-Forwarded-Port\": \"443\"}}}}]"]
  }
}

inputs = {
  deploy_method                 = "helm"
  helm_custom_values            = true
  helm_custom_values_path       = "kiali.yaml"
  use_openid_connect            = true
  openid_server_pem_certificate = <<EOT
${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).kiali.openid_server_pem_certificate}
EOT
  openid_secret                 = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).kiali.openid_secret}"
}

generate "module" {
  path      = "network.tf"
  if_exists = "overwrite"
  contents  = <<EOF

module "istio-network" {
  source = "github.com/Puhhh/terraform-istio-network?ref=v1.0.1"

  tls-name                       = "kiali"
  server-url                     = "kiali.kubernetes.local"
  tls-certificate-files          = true
  tls-crt                        = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).kiali.tls_crt}"
  tls-key                        = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).kiali.tls_key}"
  server-svc-name                = "kiali"
  server-svc-namemespace         = "istio-system"
  destination-port               = 20001
}
EOF
}
