# Create uptime check monitoring for vault 
module "vault" {
  count              = var.vault ? 1 : 0
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "vault"
}

# Create uptime check monitoring for grafana
module "grafana" {
  count              = var.kube-prometheus-stack ? 1 : 0
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "grafana"
}

# Create uptime check monitoring for prometheus
module "prometheus" {
  count              = var.kube-prometheus-stack ? 1 : 0
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "prometheus"
}

# Create uptime check monitoring for alertmanager
module "alertmanager" {
  count              = var.kube-prometheus-stack ? 1 : 0
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "alertmanager"
}

# Create uptime check monitoring for argocd
module "argocd" {
  count              = var.argo ? 1 : 0
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "argocd"
}

# Create uptime check monitoring for jenkins
module "jenkins" {
  count              = var.jenkins ? 1 : 0
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "jenkins"
}

# Create uptime check monitoring for sftpgo
module "sftpgo" {
  count              = var.sftpgo ? 1 : 0        #deploy or dont deploy
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "sftpgo"
}

# Create uptime check monitoring for dev-artemis
module "dev-artemis" {
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "dev-artemis"
}

# Create uptime check monitoring for qa-artemis
module "qa-artemis" {
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "qa-artemis"
}

# Create uptime check monitoring for stage-artemis
module "stage-artemis" {
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "stage-artemis"
}

# Create uptime check monitoring for prod-artemis
module "prod-artemis" {
  source             = "../modules/monitoring"
  google_domain_name = var.google_domain_name
  project_id         = var.project_id
  service_name       = "prod-artemis"
}
