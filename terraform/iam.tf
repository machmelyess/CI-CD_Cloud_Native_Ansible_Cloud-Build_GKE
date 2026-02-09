# 1. On récupère les infos du projet
data "google_project" "project" {}

# 2. On donne le droit de voir la facturation au Service Account par défaut de GKE

resource "google_project_iam_member" "gke_billing_viewer" {
  project = var.project_id
  role    = "roles/viewer"
  # Remplace par ton numéro de projet :
  member  = "serviceAccount:552211555480-compute@developer.gserviceaccount.com"
}