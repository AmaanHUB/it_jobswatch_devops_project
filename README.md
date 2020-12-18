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
* Pycharm IDE
* Python 3.x + installed

### Installing packages
The necessary packages needed to run this program should automatically be picked up by pycharm. You may find a a few pop ups within the IDE that state there are dependencies missing, if you simply install these through the IDE you should be set up correctly.

### Running tests

To test whether the program will work from your machine:

 * Ensure the `config.ini` file has the test environment set to `live`
 * Click the `Terminal` icon which can be found on the menu in the bottom left of Pycharm.
* Ensure you're in the root path of the project and type `python -m pytest tests/`

This should execute the tests if any fail you may have issues with this program.

### Running and using the program
To use the program simply right click on the `main.py` file and then click `Run 'main'`. This will run the command line user interface.

Follow the instructions to download via the various options given.

# Next steps
* Adding a job details search option (essentially be able to search for a specific role and return the details in a CSV)
* create a connected database for full deployment
* Build a scheduler as part of a full deployment to poll and add to the database


# New README

## Setting Up VPC

* VPC, NACL, Subnet, Route table set up steps here
* SGs, include Jenkins access too for controller

## Setting Up An Ansible Controller

* Create EC2 instance, attach to VPC
* Clone this repository and run the `ansible-setup/provisioning.sh` executable to set up everything (for now)
* Sync over `.pem` key to `~/.ssh/` on remote host
		* This is used for when it accesses the other instances (.i.e. the dev environment)


## To Do
* inventory file in or near provisioning
		* with automatic addition of IPs
* potential ansible-galaxy
* One master playbook for deployment_env
* sort out the host in deployment setup yaml,so interactive or reads maybe, so that don't need two files
* Set up security rules and VPC from an ansible file, as well as ansible controller

* Vagrant:
		* something to do with local provision file, maybe make as one with the main playbook with a conditional stuff
		* otherwise fine

* Docker testing server setup, fix the path as the python code is hardcoded so breaks whenever trying to run in a container


DOCUMENTATION TODO:
* Add how to do certain set ups here, and explain through the ansible playbooks
	* adding to `/etc/ansible/hosts` and the vault part on `ansible-controller`
	* which playbooks to run and when
		* mention how running the ec2 ones more than once will create more than one ec2
		* explain how to get the IPs from these and where to put them
	* How to set up ansible vault and what commands to use
* Explain how to set up the local dev environment with Vagrant (basically using `vagrant up`)
* Explain Jenkins set up too .i.e. the two builds and the steps etc

:zap:
