include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-kubernetes-trust-manager.git?ref=v1.0.2"
}

inputs = {
  helm-custom-values      = true
  helm-custom-values-path = "trust-manager.yaml"
  custom-bundle           = true
  custom-bundle-name      = "kubernetes-local"
  pem-certificate         = <<EOT
${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).pki_bundle}
EOT

}