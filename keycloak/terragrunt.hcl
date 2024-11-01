include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-keycloak.git?ref=v1.0.4"
}

inputs = {
  deploy_method = "helm"
  # helm
  helm_custom_values      = true
  helm_custom_values_path = "keycloak.yaml"
  helm_chart_version      = "22.2.2"
  # values
  configmap_name  = "kubernetes-local"
  admin_username  = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.admin_username}"
  admin_password  = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.admin_password}"
  proxy_type      = "edge"
  production_mode = true
  # custom_certificates
  custom_certificates_secret      = true
  custom_certificates_secret_name = "kubernetes-local"
  custom_certificates             = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).pki_bundle}"
  # database
  default_postgresql        = false
  use_db_credentials_secret = true
  db_credentials_secret = {
    secret_name  = "keycloak-pg-secret"
    host_key     = "db-host"
    port_key     = "db-port"
    dbname_key   = "db-name"
    username_key = "username"
    password_key = "password"
  }
  cloudnativepg_database          = true
  cloudnativepg_storage_size      = "3Gi"
  cloudnativepg_database_password = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.cloudnativepg_database_password}"
}

generate "module" {
  path      = "network.tf"
  if_exists = "overwrite"
  contents  = <<EOF

module "istio_network" {
  source = "github.com/Puhhh/terraform-istio-network?ref=v1.0.1"

  tls-name                       = "keycloak"
  server-url                     = "keycloak.kubernetes.local"
  tls-certificate-files          = true
  tls-crt                        = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.tls_crt}"
  tls-key                        = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.tls_key}"
  server-svc-name                = "keycloak"
  server-svc-namemespace         = "keycloak"
  destination-port               = 80
}
EOF
}