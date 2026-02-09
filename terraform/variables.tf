variable "project_id" { 
  default = "test-dev-485716" 
}

variable "gcp_region" { 
  default = "europe-west1" 
}

variable "gcp_zone" { 
  default = "europe-west1-b" 
}

# Ajoute cette variable pour ta clé JSON
variable "gcp_auth_file" {
  type    = string
  default = "test-dev-485716-3c3e84daa303.json" 
}