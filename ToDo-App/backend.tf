terraform {
  backend "s3" {
    bucket = "10weeksofcloudops-week4"
    key    = "backend/ToDo-App.tfstate"
    region = "us-east-1"
    dynamodb_table = "10weeksofcloudops-dynamo"
  }
}