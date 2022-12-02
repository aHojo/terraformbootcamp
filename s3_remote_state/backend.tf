terraform {
  backend "s3" {
    bucket = "mybucket"       #name of bucket
    key    = "path/to/my/key" # name of the state file in the bucket
    region = "us-east-1"
    # below are required
    access_key     = "value"
    secret_key     = "value"
    dynamodb_table = "s3-state-lock" # lock for concurrent runs remotely so 2 runs can't happen at the same time
  }
}
