module "artemis-cr" {
  source   = "../modules/cloudrun/"
  name     = "artemis-cr"
  location = "us-central1"
  image    = "docker.io/wordpress:latest"
  port     = 80
}
