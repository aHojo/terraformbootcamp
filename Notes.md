# Notes for terraform

## modules
each directory is a module, they have many .tf files

## Entrypoint
the convention is to use a main.tf file

need to have the first block be a `terraform` block

use the `provider` block to set up the provider

## Declare resources
```
resource "<provider>_<resource_type>" "<local_name>" {
  .... config options
} 
```

`terraform plan` shows what will be created when running `apply`

# Variables
to change default variable values you can :

use the cli:  
`terrafrom plan -var="<variable_name>"="<value>"`

in a file called exactly `terraform.tfvars`
```
vpc_cidr_block = "10.0.0.0/16"
web_subnet     = "10.0.100.0/24"
```

in a different `tfvar` files - have to use `-var-file` cli flag
` terraform apply -var-file=web-prod.tfvars`

use `ENVIRONMENT VARS` has the least precedence

`export TF_VAR_subnet_zone="us-east-1b"` --- the TF_VAR is important

### ORDER OF PRECEDENCE
1. -var and -var-file
2. terraform.tfvars
3. env vars (TF_VAR_*)

# DATA Sources

*API that fetches dynamic data from cloud providers*

# Run commands or scripts
1. user_data
2. cloud-init
3. Packer 
4. Provisioners

# cloud-init
- The Standard for customizing cloud instances
- It runs on most linux distros and cloud providers
- cloud-init can run "per-instance" or "per-boot" configuration


# Variables
- Number
- String
- Bool
- null
## Collections
groups values of the same type
- list
- map
- set
## Structural
groups values of different types
- tuple
- object

# Count Meta-argument
- count is used to manage similar resources 
- count and for_each are looping techniques