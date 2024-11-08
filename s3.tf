# s3.tf
resource "aws_s3_bucket" "terraform_state" {
  bucket = "devops-directive-tf-state"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}