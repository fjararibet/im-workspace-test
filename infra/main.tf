terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

module "im-workspace" {
  source = "./im-workspace/modules/im_cloudbuild_workspace"

  tf_version = "1.5.7"
  infra_manager_sa_roles = ["roles/owner"]
  project_id = var.project_id
  deployment_id = var.deployment_id
  im_deployment_repo_uri = var.im_deployment_repo_uri
  im_deployment_ref = var.im_deployment_ref
  im_deployment_repo_dir = "infra"

  github_app_installation_id = var.github_app_installation_id
  github_personal_access_token = var.github_personal_access_token
}

resource "google_cloud_run_v2_job" "default" {
  name     = "cloudrun-job"
  location = "us-central1"
  deletion_protection = false

  template {
    template {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/job"
      }
    }
  }
}
