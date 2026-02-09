

# Création du dépôt d'images Docker
resource "google_artifact_registry_repository" "my_repo" {
  location      = var.gcp_region
  repository_id = "webapp-repo"
  format        = "DOCKER"
}
