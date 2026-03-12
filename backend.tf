terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket-26032028"
    key          = "terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
  }
}