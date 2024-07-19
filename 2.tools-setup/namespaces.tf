module "tools" {
  source           = "mariadubita/namespace/kubernetes"
  name             = "tools"
  pod_quota        = 50
  pod_cpu_limit    = "2096m"
  pod_memory_limit = "4Gi"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }

}

module "canada" {
  source           = "ysakova90/namespace/kubernetes"
  name             = "canada"
  version          = "0.0.4"
  pod_quota        = 50
  pod_cpu_limit    = "2096m"
  pod_memory_limit = "4Gi"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
}

module "qa" {
  source           = "aia89/namespace/kubernetes"
  name             = "testns"
  pod_quota        = 50
  pod_cpu_limit    = "2096m"
  pod_memory_limit = "4Gi"
  annotations = {
    new = "application"
  }
  labels = {
    createdby = "aia89"
  }
}

module "stage" {
  source           = "Ziia21/namespace/kubernetes"
  name             = "stage"
  pod_quota        = 50
  pod_cpu_limit    = "2096m"
  pod_memory_limit = "4Gi"
  annotations = {
    new = "application"
  }
  labels = {
    createdby = "Ziia21"
  }
}

module "prod" {
  source           = "ivanababec/namespace/kubernetes"
  name             = "prod"
  version          = "0.0.4"
  pod_quota        = 50
  pod_cpu_limit    = "2096m"
  pod_memory_limit = "4Gi"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
}



module "canada-dev" {
  source = "../modules/terraform-k8s-namespace"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
  name = "canada-dev"
}

module "canada-qa" {
  source = "../modules/terraform-k8s-namespace"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
  name = "canada-qa"
}

module "canada-stage" {
  source = "../modules/terraform-k8s-namespace"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
  name = "canada-stage"
}

module "canada-prod" {
  source = "../modules/terraform-k8s-namespace"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
  name = "canada-prod"
}


module "au-prod" {
  source = "../modules/terraform-k8s-namespace"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
  name = "au-prod"
}

module "au-dev" {
  source           = "aziz200115/module/kubernetes"
  name             = "au-dev"
  version          = "0.0.6"
  pod_quota        = 50
  pod_cpu_limit    = "2096m"
  pod_memory_limit = "4Gi"
  annotations = {
    name = "au-dev"
  }
  labels = {
    name = "new-labels"
  }
}

##############################################################################################################################
#
#              Please do not touch this namespace
#
##############################################################################################################################
module "dev" {
  source = "../modules/terraform-k8s-namespace"
  annotations = {
    name = "new-annotation"
  }
  labels = {
    name = "new-labels"
  }
  name = "dev"
}
