remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-kubernetes-puhhh-s3"

    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-north-1"
  }
}

/*

remote_state {
  backend = "kubernetes"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    secret_suffix = "${basename(path_relative_to_include())}"
    config_path   = local.config_path
    namespace     = "terraform-tfstate"
  }
}
locals {
  is_windows  = (try(regex("^win", getenv("OS")), "") != "")
  config_path = local.is_windows ? "~\\.kube\\config" : "~/.kube/config"
}

*/