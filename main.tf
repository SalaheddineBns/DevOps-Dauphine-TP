resource "google_project_service" "cloudresourcemanager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "artifact_registry" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "cloud_run" {
  project = var.project_id
  service = "run.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}

resource "google_artifact_registry_repository" "website-tools" {
  repository_id = "websit-tools"
  location      = "us-central1"
  format        = "DOCKER"
}
resource "google_sql_database" "wordpres" {
  name     = "wordpres"
  instance = "main-instance"
}

resource "google_sql_user" "wordpress" {
   name     = "wordpress"
   instance = "main-instance"
   password = "ilovedevops"
}

# 📌 Déclaration de la ressource Cloud Run
resource "google_cloud_run_service" "wordpress" {
  name     = "wordpress-app"
  location = "us-central1"
  project  = var.project_id

  template {
    spec {
      containers {
        image = "us-central1-docker.pkg.dev/cloudbuildproject-449316/websit-tools/custom-wordpress:1.1"
        ports {
          container_port = 80
        }
        env {
          name  = "WORDPRESS_DB_HOST"
          value = "34.120.45.67" # Remplace par l'IP publique de ta base MySQL
        }
        env {
          name  = "WORDPRESS_DB_USER"
          value = "wordpress"
        }
        env {
          name  = "WORDPRESS_DB_PASSWORD"
          value = "ilovedevops"
        }
        env {
          name  = "WORDPRESS_DB_NAME"
          value = "wordpress"
        }
      }
    }
  }
}

# 📌 Autoriser les connexions publiques à Cloud Run
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.wordpress.location
  project     = google_cloud_run_service.wordpress.project
  service     = google_cloud_run_service.wordpress.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
