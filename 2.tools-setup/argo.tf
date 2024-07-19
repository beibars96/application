# Create a Kubernetes namespace for Cert-Manager
module "argo-terraform-k8s-namespace" {
  count     = var.argo ? 1 : 0
  source    = "farrukh90/namespace/kubernetes"
  version   = "0.0.11"
  pod_limit = 1000
  name      = "argocd"
  labels = {
    environment = "dev"
  }
  annotations = {
    managed_by = "terraform"
  }
}

#  Terraform module for deploying Cluster monitoring tools   
module "argo-terraform-helm" {
  count                = var.argo ? 1 : 0
  source               = "../modules/terraform-helm/"
  deployment_name      = "argocd"
  deployment_namespace = module.argo-terraform-k8s-namespace[0].name
  chart                = "argo-cd"
  repository           = "https://argoproj.github.io/argo-helm"
  chart_version        = var.argo-config["chart_version"]
  values_yaml          = <<-EOF

global:
  domain: "argocd.${var.google_domain_name}"
  revisionHistoryLimit: 3
  image:
    repository: quay.io/argoproj/argocd
    tag: ""

configs:
  cm:
    create: true

server:
  annotations: 
    cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
    prometheus.io/scrape: "true"

  name: server
  replicas: 1
  autoscaling:
    enabled: true
    minReplicas: 1
    maxReplicas: 5
    targetCPUUtilizationPercentage: 50
    targetMemoryUtilizationPercentage: 50
  ingress:
    enabled: true
    annotations: 
      kubernetes.io/ingress.class: "nginx"
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
      nginx.ingress.kubernetes.io/ssl-passthrough: "true"
      cert-manager.io/cluster-issuer: letsencrypt-prod-dns01
      acme.cert-manager.io/http01-edit-in-place: "true"
    hosts: 
      - "argocd.${var.google_domain_name}"
    paths:
      - /
    pathType: Prefix

    extraTls: 
      - hosts:
        - argocd.${var.google_domain_name}
        secretName: argo-tls
  EOF
}

##Terraform module that creates a Argo Rollout 
module "argo-rollouts-terraform-helm" {
  count                = var.argo ? 1 : 0
  source               = "../modules/terraform-helm/"
  deployment_name      = "argo-rollouts"
  deployment_namespace = module.argo-terraform-k8s-namespace[0].name
  chart                = "argo-rollouts"
  repository           = "https://argoproj.github.io/argo-helm"
  chart_version        = "2.26.1"
  values_yaml          = <<-EOF
  EOF
}
