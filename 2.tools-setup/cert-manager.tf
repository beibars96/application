# Create a Kubernetes namespace for Cert-Manager
module "cert-manager-terraform-k8s-namespace" {
  source    = "farrukh90/namespace/kubernetes"
  version   = "0.0.11"
  pod_limit = 1000
  name      = "cert-manager"
  labels = {
    environment = "dev"
  }
  annotations = {
    managed_by = "terraform"
  }
}

# module "cert-manager-terraform-k8s-namespace" {
#   source = "../modules/terraform-k8s-namespace/"
#   name   = "cert-manager"
# }

# Deploy Cert-Manager using Helm into the Grafana namespace
module "cert-mananger-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "cert-manager"
  deployment_namespace = module.cert-manager-terraform-k8s-namespace.name
  chart                = "cert-manager"
  chart_version        = var.cert-manager-config["chart_version"]
  repository           = "https://charts.jetstack.io"
  values_yaml          = <<EOF
podDnsPolicy: "None"
podDnsConfig:
  nameservers:
    - "8.8.4.4"
    - "8.8.8.8"
installCRDs: true
EOF
}

module "lets-encrypt" {
  depends_on = [
    module.cert-mananger-terraform-helm
  ]
  source               = "../modules/terraform-helm-local/"
  deployment_name      = "lets-encrypt"
  deployment_namespace = "cert-manager"
  deployment_path      = "charts/lets-encrypt"
  values_yaml          = <<EOF
email: "${var.email}"
project_id: "${var.project_id}"
google_domain_name: "${var.google_domain_name}"
EOF
}
