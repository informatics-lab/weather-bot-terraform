provider "aws" {
  region  = "eu-west-1"
  
  assume_role {
    role_arn = "arn:aws:iam::536099501702:role/admin"
  }
}
