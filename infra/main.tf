module "im-workspace" {
  source = "terraform-google-modules/bootstrap/google//modules/im_cloudbuild_workspace"
  version = "~> 12.0"

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
