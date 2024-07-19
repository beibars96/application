#Terraform module that creates a Kubernetes namespace for ingress resources
module "ingress-terraform-k8s-namespace" {
  source           = "danpuz7/namespace/kubernetes"
  name             = "ingress"
  pod_quota        = 50
  pod_cpu_limit    = "2096m"
  pod_memory_limit = "4Gi"
  annotations = {
    new = "application"
  }
  labels = {
    createdby = "danpuz7"
  }
}


#Terraform module for deploying an Ingress controller using Helm
module "ingress-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "ingress"
  deployment_namespace = module.ingress-terraform-k8s-namespace.namespace
  chart                = "ingress-nginx"
  chart_version        = var.ingress-controller-config["chart_version"]
  repository           = "https://kubernetes.github.io/ingress-nginx"
  values_yaml          = <<EOF
controller:
  admissionWebhooks:
    createSecretJob:
      resources:
        limits:
          cpu: 250m
          memory: 500Mi
        requests:
          cpu: 100m
          memory: 90Mi
    patchWebhookJob:
      resources:
        limits:
          cpu: 250m
          memory: 500Mi
        requests:
          cpu: 100m
          memory: 90Mi
  resources:
    limits:
      cpu: 250m
      memory: 500Mi
    requests:
      cpu: 100m
      memory: 90Mi
  service:
    create: true
    type: LoadBalancer
    loadBalancerSourceRanges: [
        "${var.ingress-controller-config["loadBalancerSourceRanges"]}",
    ]
  EOF
}