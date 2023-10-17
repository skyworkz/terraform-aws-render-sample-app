resource "random_pet" "default" {}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.namespace}-sample-app-${random_pet.default.id}"
}


resource "aws_cognito_user_pool" "app_user_pool" {
  name                     = "${var.namespace}-sample-app-pool-${random_pet.default.id}"
  auto_verified_attributes = ["email"]
}

resource "render_service" "web_static_app_container" {
  name = "${var.namespace}-sample-app-static-${random_pet.default.id}"
  repo = "https://github.com/render-examples/nextjs-hello-world"
  type = "static_site"

  static_site_details = {
    build_command = "yarn; yarn build; yarn next export"
    publish_path  = "out"
  }
}

resource "render_service" "web_api_container" {
  name = "${var.namespace}-sample-app-api-${random_pet.default.id}"
  repo = "https://github.com/render-examples/hapi-quick-start"
  type = "web_service"

  web_service_details = {
    env = "node"

    native = {
      build_command = "npm install"
      start_command = "node server.js"
    }
  }
}

resource "render_service_environment" "web_static_app_container" {
  service = render_service.web_static_app_container.id

  variables = [{
    key   = "API_URL"
    value = render_service.web_api_container.web_service_details.url
  }]
}

resource "render_service_environment" "web_api_container" {
  service = render_service.web_api_container.id

  variables = [{
    key   = "S3_BUCKET"
    value = aws_s3_bucket.app_bucket.bucket
    }, {
    key   = "COGNITO_USER_PULL_ARN"
    value = aws_cognito_user_pool.app_user_pool.arn
  }]
}


