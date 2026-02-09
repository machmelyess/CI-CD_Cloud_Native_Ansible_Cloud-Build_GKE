
# Ce bloc crée les 3 machines qui manquent à l'appel
resource "google_container_node_pool" "primary_nodes" {
  name       = "onertech-node-pool"
  location   = var.gcp_zone
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    disk_size_gb = 20
    disk_type    = "pd-standard"

    # Très important pour que tes nœuds puissent parler aux APIs Google
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_cluster" "primary" {
  name     = "onertech-gke-cluster"
  location = var.gcp_zone

  # Ajoute cette ligne impérativement ici :
  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc_onertech.name
  
  # Assure-toi aussi que le cluster attend l'API
  depends_on = [google_project_service.container]
}
