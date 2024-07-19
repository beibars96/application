# Convert these resources into a module
resource "google_artifact_registry_repository" "my-repo" {
  provider      = google-beta
  location      = var.gke_config["region"]
  repository_id = "nodejs"
  description   = "used to store nodejs images"
  format        = "DOCKER"
}
resource "google_artifact_registry_repository" "my-artemis-repo" {
  provider      = google-beta
  location      = var.gke_config["region"]
  repository_id = "artemis"
  description   = "used to store artemis images"
  format        = "DOCKER"
}
resource "google_artifact_registry_repository" "tools" {
  provider      = google-beta
  location      = var.gke_config["region"]
  repository_id = "tools"
  description   = "used to store artemis images"
  format        = "DOCKER"
}
resource "google_artifact_registry_repository" "ots" {
  provider      = google-beta
  location      = var.gke_config["region"]
  repository_id = "ots"
  description   = "used to store ots images"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "python" {
  provider      = google-beta
  location      = var.gke_config["region"]
  repository_id = "python"
  description   = "used to store python code"
  format        = "PYTHON"
}

resource "google_artifact_registry_repository" "demo" {
  provider      = google-beta
  location      = var.gke_config["region"]
  repository_id = "demo"
  description   = "used to store artemis images"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "feb-project" {
  provider      = google-beta
  location      = var.gke_config["region"]
  repository_id = "feb-project"
  description   = "used to store artemis images"
  format        = "DOCKER"
}
