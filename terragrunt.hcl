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