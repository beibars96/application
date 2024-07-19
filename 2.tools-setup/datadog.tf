module "datadog-terraform-k8s-namespace" {
  source    = "farrukh90/namespace/kubernetes"
  version   = "0.0.11"
  pod_limit = 1000
  count     = var.datadog ? 1 : 0
  name      = "datadog"
  labels = {
    environment = "dev"
  }
  annotations = {
    managed_by = "terraform"
  }
}


module "datadog-terraform-helm" {
  count                = var.datadog ? 1 : 0
  source               = "../modules/terraform-helm/"
  deployment_name      = "datadog"
  deployment_namespace = module.datadog-terraform-k8s-namespace[0].name
  chart                = "datadog"
  chart_version        = "3.2.2"
  repository           = "https://helm.datadoghq.com"
  values_yaml          = <<EOF
datadog:
  clusterName: "${var.gke_config["cluster_name"]}"
  site: "${var.datadog-config["site"]}"
  apiKey: "${var.datadog-config["apiKey"]}"
  logs:
    enabled: true
    containerCollectAll: true
# clusterAgent:
#   resources: 
#     requests:
#       cpu: "${var.datadog-config["cpu_requests"]}"
#       memory: "${var.datadog-config["memory_requests"]}"
#     limits:
#       cpu: "${var.datadog-config["cpu_limits"]}"
#       memory: "${var.datadog-config["memory_limits"]}"
EOF
}
