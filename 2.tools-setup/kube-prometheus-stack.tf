# Create a Kubernetes namespace for kube-prometheus-stack
module "kube-prometheus-stack-terraform-k8s-namespace" {
  source    = "farrukh90/namespace/kubernetes"
  version   = "0.0.11"
  pod_limit = 1000
  count     = var.kube-prometheus-stack ? 1 : 0
  name      = "kube-prometheus-stack"
  labels = {
    environment = "dev"
  }
  annotations = {
    managed_by = "terraform"
  }
}

# Deploy kube-prometheus-stack using Helm into the kube-prometheus-stack namespace
module "kube-prometheus-stack-terraform-helm" {
  count                = var.kube-prometheus-stack ? 1 : 0
  source               = "../modules/terraform-helm/"
  deployment_name      = "kube-prometheus-stack"
  deployment_namespace = module.kube-prometheus-stack-terraform-k8s-namespace[0].name
  chart                = "kube-prometheus-stack"
  repository           = "https://prometheus-community.github.io/helm-charts"
  chart_version        = var.kube-prometheus-stack-config["chart_version"]
  values_yaml          = <<-EOF

# Needs to be disabled for EKS and GKE
kubeScheduler:
  enabled: false

# Needs to be disabled for EKS and GKE
kubeControllerManager:
  enabled: false

grafana:
  adminPassword: prom-operator
  enabled: true
  ingress:
    enabled: true
    annotations: 
      ingress.kubernetes.io/ssl-redirect: "false"
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod-dns01
      acme.cert-manager.io/http01-edit-in-place: "true"
    hosts: 
    - "grafana.${var.google_domain_name}"
    path: /
    tls: 
    - secretName: grafana-tls
      hosts:
      - "grafana.${var.google_domain_name}"

prometheus:
  prometheusSpec:
    retentionSize: "20GB"
    retention: "30d"
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: standard-rwo
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: 20Gi
    resources:
      requests:
        memory: "40Mi"
        cpu: "20m"
      limits:
        memory: "2Gi"
        cpu: "1"




    additionalScrapeConfigs: 
    - job_name: 'kubernetes-pods'
      kubernetes_sd_configs:
        - role: pod
      relabel_configs:
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
          action: replace
          target_label: __address__
          regex: (.+):(?:\d+);(\d+)
          replacement: ${1}:${2}
        - source_labels: [__meta_kubernetes_namespace]
          action: replace
          target_label: namespace
        - source_labels: [__meta_kubernetes_pod_name]
          action: replace
          target_label: pod

  enabled: true
  ingress:
    enabled: true
    annotations: 
      ingress.kubernetes.io/ssl-redirect: "false"
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod-dns01
      acme.cert-manager.io/http01-edit-in-place: "true"
    hosts: 
      - "prometheus.${var.google_domain_name}"
    path: /
    pathType: Prefix
    tls: 
      - secretName: prometheus-tls
        hosts:
          - "prometheus.${var.google_domain_name}"
    
alertmanager:
  enabled: true
  ingress:
    enabled: true
    annotations: 
      ingress.kubernetes.io/ssl-redirect: "false"
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod-dns01
      acme.cert-manager.io/http01-edit-in-place: "true"
    hosts: 
      - "alertmanager.${var.google_domain_name}"
    path: /
    pathType: Prefix
    tls: 
      - secretName: alertmanager-tls
        hosts:
          - "alertmanager.${var.google_domain_name}"

  EOF
}

    