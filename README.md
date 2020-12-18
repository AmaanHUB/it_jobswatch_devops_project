Introduction

## Introduction
The aim of this project is to create a simple service that can scrape useful data from ITJobswatch.

## Current Scope
At present the app is set up to be cloned and used to simply scrape the below services:

1. Home page top 30 job/roles / skills which can be found [here]()

The aim will be to expand this to further services such as:

* Regular polling of pages and writing to a database for longer terms stats
* Bespoke calls for specific job role data

And much more.

## Usage
_Pre-Requisites_
* Python 3.x + installed


### Running tests

To test whether the program will work from your machine:

* Ensure the `config.ini` file has the test environment set to `live`
* Ensure you're in the root path of the project and type `python -m pytest tests/`

### Running and using the program
* Run the `main.py` file

# New README

## Setting Up VPC

* On AWS, create a VPC with your chosen private IP.
	* Start with the NACL open to everyone (inbound rules and outbound)
	* Create a public subnet with whatever chosen private IP and associate it with this VPC
* Create a route table:
	* Allow access from local IPs within subnet (xxx.xxx.xxx.xxx/16) and an internet gateway that is open to 0.0.0.0/0
* Create security groups:
	* **Ansible Controller** -
		* Inbound
			- 80, 443 (open to everyone)
			- 22 (to personal public IP and Jenkins IP if made at this point)
		* Outbound
			- All
	* **For the other instances** -
			- The same except port 22 is from the _private IP of the ansible controller_
				- this will be modified later when the ansible-controller instance has been made

## Setting Up An Ansible Controller

* Create an EC2 instance from a Ubuntu 18.04 image, attach it to the previously created VPC and the ansible-controller security group
* Clone this repository into it with the `git clone` command and run the `ansible-setup/provisioning.sh` executable to set up everything (for now)
* Sync over `.pem` key to `~/.ssh/` on remote host (can use `rsync`)
		* This is used for when it accesses the other instances (.i.e. the dev environment)


## Using Ansible Vault

* A `vault` must be created to contain the AWS access and secret key so that one can use the AWSCLI (which the previous provision installed) properly.
* On the **Ansible Controller machine**, create a file called `aws_keys.yaml` and insert the relevant information into the file with this format:
```yaml
aws_secret_key: <KEY_HERE>
aws_access_key: <ACCESS_KEY_HERE>
```
* Move it into `/etc/ansible/groups_vars/all/` (make these folders if they do not exist already)
* Run the following command and choose the password of your choice
```sh
ansible-vault encrypt path/to/file
```
## Creating The Deployment Environment

* Run the provisioning/deployment_machine/create_ec2.yaml playbook with the following command and use your previously assigned vault password
```sh
ansible-playbook provisioning/deployment_machine/create_ec2.yaml --ask-vault --tags create_ec2
```
* **N.B. Getting the IP of this instance is not automated yet, so get this from the EC2 Instance interface**
* Add the private IP of this newly created instance to the bottom of your `/etc/ansible/hosts` file such as:
```ini
[development_env]
ip_here ansible_connection=ssh ansible_ssh_private_key_file=/path/to/key
```
* One can then run this command to actually set up the environment probably **NOTE, change this bit when I make a single document**
```sh
ansible-playbook provisioning/deployment_machine/setup_deploy_env.yaml
```

## Running A Local Development Environment

* Prequisities:
	- Vagrant
	- Virtualbox
* Run `vagrant up`
* It is set up by using an ansible playbook when the virtual machine is created


## EARLY ACCESS

* Some playbooks are concerned with setting up an EC2 instance that is a testing environment (.i.e. with Jenkins running), these are not working yet because they use docker and the code is hardcoded in such a way that this will not work.
* Though you can create the instance with the playbook, just Jenkins will not work (as it will not listen to the proper ports when called through the playbook) and the testing will always fail due to the aforementioned reason
* Usage is similar to the **Deployment Environments** setup

DOCUMENTATION TODO:

* Add how to do certain set ups here, and explain through the ansible playbooks
	* adding to `/etc/ansible/hosts` and the vault part on `ansible-controller`
	* which playbooks to run and when
		* mention how running the ec2 ones more than once will create more than one ec2
		* explain how to get the IPs from these and where to put them
	* How to set up ansible vault and what commands to use
* Explain how to set up the local dev environment with Vagrant (basically using `vagrant up`)
* Explain Jenkins set up too .i.e. the two builds and the steps etc

## To Do
* Set up security rules and VPC from an ansible file, as well as ansible controller
* inventory file in or near provisioning
		* with automatic addition of IPs
* potential ansible-galaxy
* One master playbook for deployment_env
* sort out the host in deployment setup yaml,so interactive or reads maybe, so that don't need two files

* Vagrant:
		* something to do with local provision file, maybe make as one with the main playbook with a conditional stuff
		* otherwise fine

* Docker testing server setup, fix the path as the python code is hardcoded so breaks whenever trying to run in a container
	* **testing_env** script should be used for this in the future, though the ports need to be fixed
