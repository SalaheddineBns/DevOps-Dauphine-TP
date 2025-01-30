

# 🚀 Activer les APIs nécessaires pour le projet
resource "google_project_service" "ressource_manager" {
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "ressource_usage" {
  service    = "serviceusage.googleapis.com"
  depends_on = [google_project_service.ressource_manager]
}

resource "google_project_service" "artifact" {
  service    = "artifactregistry.googleapis.com"
  depends_on = [google_project_service.ressource_manager]
}

resource "google_project_service" "sqladmin" {
  service    = "sqladmin.googleapis.com"
  depends_on = [google_project_service.ressource_manager]
}

resource "google_project_service" "cloudbuild" {
  service    = "cloudbuild.googleapis.com"
  depends_on = [google_project_service.ressource_manager]
}





# Création du repository Artifact Registry
resource "google_artifact_registry_repository" "website-tools" {
  repository_id = "website-tools"
  location      = "us-central1"
  format        = "DOCKER"
}


resource "google_sql_database" "wordpress" {
  name     = "wordpress"
  instance = "main-instance"
}

#  Création d'un utilisateur MySQL
resource "google_sql_user" "wordpress_user" {
  name     = "wordpress"
  instance = "main-instance"
  password = "ilovedevops" 
}
