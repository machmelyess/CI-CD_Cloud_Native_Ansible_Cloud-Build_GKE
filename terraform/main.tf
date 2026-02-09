# 1. Définition du fournisseur (Provider)
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_auth_file)
  project     = var.project_id
  region      = var.gcp_region
  zone        = var.gcp_zone
}

# 2. Création du Réseau VPC
resource "google_compute_network" "vpc_onertech" {
  name                    = "vpc-onertech"
  auto_create_subnetworks = true
}

# 3. Activation des APIs nécessaires sur GCP
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  service = "artifactregistry.googleapis.com"
}
# Création du dépôt Artifact Registry pour tes images Docker
resource "google_artifact_registry_repository" "onertech_repo" {
  location      = var.gcp_region
  repository_id = "onertech-repo"
  description   = "Depot Docker pour l'application Billing"
  format        = "DOCKER"

  # Optionnel : Empêche la suppression accidentelle des images
  cleanup_policy_dry_run = false

  # On s'assure que l'API est activée avant de créer le dépôt
  depends_on = [google_project_service.artifactregistry]
}