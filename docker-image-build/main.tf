
resource "random_pet" "this" {}

resource "aws_ecr_repository" "this" {
  name = "${random_pet.this.id}-ecr"
}

data "aws_caller_identity" "this" {}
data "aws_region" "current" {}
data "aws_ecr_authorization_token" "token" {}

locals {
  tag_version     = "1.0"
  ecr_address     = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
  ecr_image       = format("%v/%v:%v", local.ecr_address, aws_ecr_repository.this.id, local.tag_version)
}

resource "docker_registry_image" "ingestion_lambda" {
  name = local.ecr_image

  build {
    context = "./"
    dockerfile = "Dockerfile"
  }
}

output "repo" {
  value = aws_ecr_repository.this.id
}
