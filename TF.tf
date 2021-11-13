TUTORIAL
How To Protect Sensitive Data in Terraform

# 
The author selected the Free and Open Source Fund to receive a donation as part of the Write for DOnations program.

Introduction
Terraform provides automation to provision your infrastructure in the cloud. To do this, Terraform authenticates with cloud providers (and other providers) to deploy the resources and perform the planned actions. However, the information Terraform needs for authentication is very valuable, and generally, is sensitive information that you should always keep secret since it unlocks access to your services. For example, you can consider API keys or passwords for database users as sensitive data.

If a malicious third party were to acquire the sensitive information, they would be able to breach the security systems by presenting themselves as a known trusted user. In turn, they would be able to modify, delete, and replace the resources and services that are available under the scope of the obtained keys. To prevent this from happening, it is essential to properly secure your project and safeguard its state file, which stores all the project secrets.

By default, Terraform stores the state file locally in the form of unencrypted JSON, allowing anyone with access to the project files to read the secrets. While a solution to this is to restrict access to the files on disk, another option is to store the state remotely in a backend that encrypts the data automatically, such as DigitalOcean Spaces.

In this tutorial, you’ll hide sensitive data in outputs during execution and store your state in a secure cloud object storage, which encrypts data at rest. You’ll use DigitalOcean Spaces in this tutorial as your cloud object storage. You’ll also learn how to mark variables as sensitive, as well as explore tfmask, which is an open source program written in Go that dynamically censors values in the Terraform execution log output.

Prerequisites
A DigitalOcean Personal Access Token, which you can create via the DigitalOcean control panel. You can find instructions in the DigitalOcean product documents, How to Create a Personal Access Token.
Terraform installed on your local machine and a project set up with the DigitalOcean provider. Complete Step 1 and Step 2 of the How To Use Terraform with DigitalOcean tutorial, and be sure to name the project folder terraform-sensitive, instead of loadbalance. During Step 2, do not include the pvt_key variable and the SSH key resource.
A DigitalOcean Space with API keys (access and secret). To learn how to create a DigitalOcean Space and API keys, see the tutorial, How To Create a DigitalOcean Space and API Key.
Note: This tutorial has specifically been tested with Terraform 1.0.2.

Marking Outputs as sensitive
In this step, you’ll hide outputs in code by setting their sensitive parameter to true. This is useful when secret values are part of the Terraform output that you’re storing indefinitely, or if you need to share the output logs beyond your team for analysis.

Assuming you are in the terraform-sensitive directory, which you created as part of the prerequisites, you’ll define a Droplet and an output showing its IP address. You’ll store it in a file named droplets.tf, so create and open it for editing by running:

links {https://www.digitalocean.com/community/tutorials/how-to-protect-sensitive-data-in-terraform }
