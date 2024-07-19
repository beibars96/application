
# Instructions

----
### Step1
Please navigate to 
```
https://console.cloud.google.com
```
----
### Step2
#### Login with your brand new account
#### Search for "Create a Project" Tab
#### Create new project call it 
```
terraform-project-WHATEVER_YOU_WANT      # It should start with terraform-project
```

#### Navigate to Cloud Storage, and create a bucket 
```
terraform-project-WHATEVER_YOU_WANT      # It should start with terraform-project
```
----
### Step3
#### Create a new file here called 
```
0.account_setup/configurations.tfvars
```
#### and add the following message there 
```
# Please get your AWS Domain
google_domain_name = "AWS_DOMAIN"

# Use GCP account email
email              = "EMAIL"

# Add bucketname you created above
bucket_name        = "terraform-project-WHATEVER_YOU_WANT"

# Add project name you created above
project_id         = "terraform-project-WHATEVER_YOU_WANT"   # Keep in mind, ID not the name
```
----
### Step4

```
bash login.sh 
```
#### And follow the instructions. It asks you to login 2 times
----


### To Enable services, please set service to "true" 
#### Examples: 
```
# List of services to activate
kube-prometheus-stack   = true
argo                    = false
datadog                 = false
jenkins                 = false
sosivio                 = false
sumologic               = false
vault                   = false
sftpgo                  = false
ots                     = false
loki                    = false
ghrunner                = true



# Configuring datadog DO NOT CONTINUE. WE WILL WORK IN CLASS
datadog-config = {
    deployment_name = "datadog"
    apiKey          = ""
    site            = "us5.datadoghq.com"
    cpu_requests    = "200m"
    memory_requests = "256Mi"
    cpu_limits      = "500m"
    memory_limits   = "1024Mi"
}
