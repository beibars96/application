## This folder sets up your cluster
----
## Instructions

1. Set up backend
```
source ../scripts/setenv.sh

```

2. Configure tfenv if needed
```
tfenv install 1.5.0
tfenv use 1.5.0
```


3. Run terraform commands
```
terraform init
terraform apply
```
 