# This block sets a project ID
variable "project_id" {
  description = "Please provide a project ID"
  type        = string
  default     = ""
}

# This block sets an email
variable "email" {
  description = "Please provide an email"
  type        = string
  default     = ""
}

# This block sets a google_domain_name
variable "google_domain_name" {
  description = "Please provide a google_domain_name"
  type        = string
  default     = ""
}

# This block is used to setup cert-manager
variable "cert-manager-config" {
  type        = map(any)
  description = "Please define cert-manager configurations"
  default = {
    deployment_name = "cert-manager"
    chart_version   = "1.10.0"
  }
}

# This block is used to setup external-dns
variable "external-dns-config" {
  type        = map(any)
  description = "Please define external-dns configurations"
  default = {
    deployment_name = "external-dns"
    chart_version   = "7.5.7"
  }
}

variable "ots" {
  description = "Deploy ots or no?"
  type        = bool
  default     = false
}

# This block is used to setup kube-state-metrics
variable "kube-state-metrics-config" {
  type = map(any)
  default = {
    deployment_name = "kube-state-metrics"
    chart_version   = "4.22.1"
  }
}

variable "vault-config" {
  type        = map(any)
  description = "Please define vault configurations"
  default = {
    deployment_name = "vault"
    chart_version   = "0.27.0"
  }
}

variable "vault" {
  description = "Deploy vault or no?"
  type        = bool
  default     = false
}

variable "gke_config" {
  type        = map(any)
  description = "description"
  default = {
    region         = "us-central1"
    zone           = "us-central1-c"
    cluster_name   = "project-cluster"
    machine_type   = "e2-medium"
    node_count     = 1
    node_pool_name = "my-node-pool"
    preemptible    = true
    node_version   = "1.23.5-gke.1500" # finds build version automatically based on region. We can change it to 1.21   . In this case it will automatically find minor version
  }
}

variable "datadog-config" {
  type        = map(any)
  description = "Please provide datadog config"
  default = {
    deployment_name = "datadog"
    apiKey          = "486adc28b54026bb6a42480386407778"
    site            = "us5.datadoghq.com"
    cpu_requests    = "200m"
    memory_requests = "256Mi"
    cpu_limits      = "500m"
    memory_limits   = "1024Mi"
  }
}




variable "datadog" {
  description = "Deploy datadog or no?"
  type        = bool
  default     = false
}


variable "repository_id" {
  type    = string
  default = ""
}

variable "format" {
  type    = string
  default = "DOCKER"
}

variable "description" {
  type    = string
  default = ""
}

# This block is used to setup ingress controller
variable "ingress-controller-config" {
  type        = map(any)
  description = "Please define ingress-controller configurations"
  default = {
    deployment_name          = "ingress-controller"
    chart_version            = "4.10.1"
    loadBalancerSourceRanges = "0.0.0.0/0"
  }
}

# This block is used to setup ingress controller
variable "sftpgo-config" {
  type        = map(any)
  description = "Please define sftpgo configurations"
  default = {
    deployment_name = "sftpgo"
    chart_version   = "0.12.0"

  }
}

variable "sftpgo" {
  description = "Deploy sftpgo or no?"
  type        = bool
  default     = false
}


# This block is used to setup ingress controller
variable "argo-config" {
  type        = map(any)
  description = "Please define argo configurations"
  default = {
    deployment_name = "argo"
    chart_version   = "7.1.3"
  }
}

variable "argo" {
  description = "Deploy argo or no?"
  type        = bool
  default     = false
}


# This block is used to setup jenkins controller
variable "jenkins-config" {
  type        = map(any)
  description = "Please define jenkins configurations"
  default = {
    deployment_name = "jenkins"
    chart_version   = "4.6.1"
  }
}

variable "jenkins" {
  description = "Deploy jenkins or no?"
  type        = bool
  default     = false
}



# This block is used to setup github action runner
variable "ghrunner-config" {
  type        = map(any)
  description = "Please define ghrunner configurations"
  default = {
    deployment_name            = "ghrunner"
    chart_version              = "0.22.0"
    github_app_id              = "236776"
    github_app_installation_id = "29078416"
  }
}

# This block is used to setup sumologic
variable "sumologic-config" {
  type        = map(any)
  description = "Please define sumologic configurations"
  default = {
    deployment_name = "sumologic"
    chart_version   = "3.9.0"
  }
}

variable "sumologic" {
  description = "Deploy sumologic or no?"
  type        = bool
  default     = false
}

# This block is used to setup sosivio
variable "sosivio-config" {
  type        = map(any)
  description = "Please define sosivio configurations"
  default = {
    deployment_name = "sosivio"
  }
}

variable "sosivio" {
  description = "Deploy sosivio or no?"
  type        = bool
  default     = false
}

# # This block is used to setup rancher
# variable "rancher-config" {
#   type        = map(any)
#   description = "Please define rancher configurations"
#   default = {
#     deployment_name = "rancher"
#   }
# }


variable "ghrunner" {
  description = "Deploy ghrunner or no?"
  type        = bool
  default     = false
}


# This block is used to setup kube-prometheus-stack
variable "kube-prometheus-stack-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "kube-prometheus-stack"
    chart_version   = "56.6.0"
  }
}

variable "kube-prometheus-stack" {
  description = "Deploy kube-prometheus-stack or no?"
  type        = bool
  default     = false
}
