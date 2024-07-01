provider "aws" {
  region  = "us-east-1"
  version = "2.70.0"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08a0d1e16fc3f61ea"
  instance_type = "t2.micro"

  tags = {
    Name = "MyApp"
  }
}

resource "aws_db_instance" "rds" {
  identifier          = "rds"
  instance_class      = "db.t3.micro"
  allocated_storage   = 5
  engine              = "postgres"
  engine_version      = "14.1"
  username            = "${var.db_user}"
  password            = "${var.db_password}"
  publicly_accessible = true
  skip_final_snapshot = true
}

resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket"
  tags   = {
    Name = "MyBucket"
  }
}

resource "aws_sqs_queue" "sqs-queue" {
  queue_name                        = "sqs-queue"
  delay_seconds                     = "${var.sqs_delay_seconds}"
  maximum_message_size              = "${var.maximum_message_size}"
  message_retention_period          = "${var.message_retention_period}"
  receive_message_wait_time_seconds = "${var.receive_message_wait_time_seconds}"
  tags                              = {
    Name = "MySQS"
  }
}




