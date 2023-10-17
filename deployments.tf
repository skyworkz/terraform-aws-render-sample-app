module "app_a" {
  source = "./modules/application-sample"

  namespace = "application-a"
}

module "app_b" {
  source = "./modules/application-sample"

  namespace = "application-b"
}
