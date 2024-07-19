# Create a Kubernetes namespace for External-dns
module "external-dns-terraform-k8s-namespace" {
  source    = "farrukh90/namespace/kubernetes"
  version   = "0.0.11"
  pod_limit = 1000
  name      = "external-dns"
  labels = {
    environment = "dev"
  }
  annotations = {
    managed_by = "terraform"
  }
}

# Creates GCP service account called "pro-external-dns"
resource "google_service_account" "external-dns" {
  account_id   = "pro-external-dns"
  display_name = "Used for external-dns"
  project      = var.project_id
}

# Creates a key for "pro-external-dns"  GCP service account
resource "google_service_account_key" "external-dns" {
  service_account_id = google_service_account.external-dns.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

# Attaches DNS Admin role to above service account
resource "google_project_iam_binding" "externald-dns" {
  project = var.project_id
  role    = "roles/dns.admin"
  members = [
    "serviceAccount:${google_service_account.external-dns.email}"
  ]
}

# Creates local kubernetes secret called external-dns in external-dns namespace
resource "kubernetes_secret" "external_dns_secret" {
  metadata {
    name      = "external-dns"
    namespace = module.external-dns-terraform-k8s-namespace.name
  }
  data = {
    "credentials.json" = base64decode(google_service_account_key.external-dns.private_key)
  }
  type = "generic"
}

resource "kubernetes_secret" "external_dns_secret_dev" {
  metadata {
    name      = "letsencrypt-prod-dns01-sa"
    namespace = "cert-manager"
  }
  data = {
    "credentials.json" = base64decode(google_service_account_key.external-dns.private_key)
  }
  type = "generic"
}

module "external-dns-terraform-helm" {
  depends_on = [
    kubernetes_secret.external_dns_secret
  ]
  source               = "../modules/terraform-helm/"
  deployment_name      = "external-dns"
  deployment_namespace = module.external-dns-terraform-k8s-namespace.name
  chart                = "external-dns"
  chart_version        = var.external-dns-config["chart_version"]
  repository           = "https://charts.bitnami.com/bitnami"
  values_yaml          = <<EOF
commonAnnotations: {
  "cluster-autoscaler.kubernetes.io/safe-to-evict": "true"
}
provider: google
google:
  project: "${var.project_id}"
  # Uses external-dns secret to assume role
  serviceAccountSecret: external-dns 
rbac:
  create: true
# Below policy is need to keep DNS records clean
# policy: sync
EOF
}
