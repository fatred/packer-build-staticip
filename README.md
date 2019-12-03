# packer-build-staticip
Example repo to use packer against a VMware environment without DHCP and then setup instances using terraform and VM Customisation Spec.

## How to use me
### Packer
#### Pre-reqs: 
* Install packer. We used v1.4.5 from [here](http://packer.io/downloads.html)
* Install the JetBrains packer-builder-vsphere-iso module into ~/.packer.d/plugins - fetch from [here](https://github.com/jetbrains-infra/packer-builder-vsphere/releases)
* An account in vSphere with the [correct permissions](https://github.com/jetbrains-infra/packer-builder-vsphere/issues/97#issuecomment-436063235)
* A copy of the Ubuntu 18.04 Server iso. We use 18.04.3 from [here](http://cdimage.ubuntu.com/releases/18.04.3/release/). If you change that, update the shasum in [ubuntu-18.json](ubuntu-18.json)

#### Process
1) Enter the packer/ubuntu-18 directory 
2) Setup all the vars in the variables-lab.json to meet your environment. _Do not store your vcs creds in your variables!_
3) Export the creds in your cli session 
```bash
export PACKER_USER='packer@vsphere.local'
export PACKER_PASS='lololololololololo10!'
```
4) Run the packer validate proces
```bash
packer validate -var-file variables-lab.json ubuntu-18.json
```

5) Assuming you have a valid template, execute.
```bash
packer build -var-file variables-lab.json ubuntu-18.json
```

_Packer will now take about 15 mins to build your image and mark it as a template_

### Terraform
#### Pre-reqs
* Install terraform. We used v1.12.13 from [here](https://www.terraform.io/downloads.html)
* An account in vSphere with the [correct permissions](https://www.terraform.io/docs/providers/vsphere/) 
* A VM Customisation spec in vCenter for Ubuntu-18 - we used [this doc](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.vm_admin.doc/GUID-9A5093A5-C54F-4502-941B-3F9C0F573A39.html)

#### Process
1) Enter the terraform/lab directory
2) Setup all the vars in globals.tf _Do not store your vcs creds in your variables!_
3) Validate/extend the vcs_data.tf to include any additional assets (like datastores/vm port groups) you want to reference in your builds
4) Setup your instance(s) you will build in inst_my_vm.tf
5) export the creds in your cli session
```bash
export TF_VAR_vsphere_user='terraform@vsphere.local'
export TF_VAR_vsphere_password='lololololololololololo10!'
```
6) Run a terraform init
```bash
terraform init
```
7) Run a terraform validate
```bash
terraform validate
```
8) Assuming you have a valid tf env, execute a plan
```bash
terraform plan
```
9) Assuming your plan worked and you got the outcomes you expected, execute an apply
```bash
terraform apply
```