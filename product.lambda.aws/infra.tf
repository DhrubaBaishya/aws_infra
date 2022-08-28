# variable "maven_project_version" {
#   description = "Maven Package Version"
#   type = string
# }

provider "aws" {
  region = "ap-south-1"
  access_key = "..."
  secret_key = "..."
}

terraform {
  backend "s3" {
    bucket = "store-terraform-state-management"
    key = "store/terraform.tfstate"
    region = "ap-south-1"
    access_key = "..."
    secret_key = "..."
  }
}



resource "aws_iam_role" "lambda_exec" {
  name = "serverless_test_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#   role       = aws_iam_role.lambda_exec.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# resource "aws_lambda_function" "test_lambda" {
#   # If the file is not in the current working directory you will need to include a 
#   # path.module in the filename.
#   filename      = "${path.module}/product.lambda-1.0.0.jar"
#   function_name = "product_lambda"
#   role          = aws_iam_role.lambda_exec.arn
#   handler       = "index.test"

#   # The filebase64sha256() function is available in Terraform 0.11.12 and later
#   # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
#   # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
#   source_code_hash = filebase64sha256("lambda_function_payload.zip")

#   runtime = "nodejs12.x"

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
# }