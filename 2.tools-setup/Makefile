# Builds all tools 
build:
		source  ../scripts/setenv.sh && terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars --auto-approve

# Deploy just Grafana 
deploy-grafana:
	source ../scripts/setenv.sh && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.grafana-terraform-k8s-namespace --auto-approve && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.grafana-terraform-helm --auto-approve

# Deploy just Prometheus 
deploy-prometheus:
	source ../scripts/setenv.sh && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.prometheus-terraform-k8s-namespace --auto-approve && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.prometheus-terraform-helm --auto-approve

# Deploy just Datadog 
deploy-datadog:
	source ../scripts/setenv.sh && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.datadog-terraform-k8s-namespace --auto-approve && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.datadog-terraform-helm --auto-approve

# Deploy just Vault 
deploy-vault:
	source ../scripts/setenv.sh && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.vault-terraform-k8s-namespace --auto-approve && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.vault-terraform-helm --auto-approve

# Deploy just Argo 
deploy-argo:
	source ../scripts/setenv.sh && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.argo-terraform-k8s-namespace --auto-approve && \
	terraform apply -var-file ~/project_infrastructure/0.account_setup/configurations.tfvars -target module.argo-terraform-helm --auto-approve


# Find out list of pods in each worker node
count-pods-in-nodes:
	for node in $$(kubectl get nodes | awk '{if (NR!=1) {print $$1}}'); do echo ""; echo "Checking $${node}..."; kubectl describe node $${node} | grep "Non-terminated" ; done


# get argocd password by running 
#  make gap
gap:
	echo && kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d &&  echo
	
get-sosivio-password:
	kubectl get secret -n sosivio sosivio-admin-otp -o jsonpath='{.data.password}' | base64 -d
