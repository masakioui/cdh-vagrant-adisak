<img src="https://www.cloudera.com/content/dam/www/marketing/media-kit/logo-assets/cloudera_logo_darkorange.png" alt="drawing" width="200"/> <img src="https://s3.amazonaws.com/hashicorp-marketing-web-assets/brand/Vagrant_VerticalLogo_FullColor.rkvQk0Hax.svg" alt="drawing" height="200"/> <img src="https://www.virtualbox.org/graphics/vbox_logo2_gradient.png" alt="drawing" height="200"/>

## Introduction

Setting up a Hadoop ecosystem for learning, developing, and testing could be a time consuming task.
[Cloudera](https://www.cloudera.org) offers a guide for installing a Proof-of-Concept version of their Hadoop platform called [Cloudera Distribution for Hadoop (CDH)](https://www.cloudera.com/documentation/enterprise/latest/topics/cm_ig_non_production.html#install_embedded_db).
This repository aims to automate the configuration of a cluster in a local machine using [Virtualbox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/). **Note:** The guide explains how to install CDH Express Edition, that is good for learning and testing, but not for production or commercial use.

The idea of repository was inspired by [ambari-vagrant](https://github.com/u39kun/ambari-vagrant). Most of the configuration is taken from there. 

## Requisites
- A computer with at least 16GB of RAM and 8 CPU threads.
- This works with Mac OS, Linux, and Windows 10.
    -   For Windows 10:
        - Execute the scripts in the Windows Subsystem for Linux (WSL)
        - Install the same version of Vagrant in Windows and WSL
        - Virtualbox must be installed only on Windows 10
        - Add the following to your .bashrc: `export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"`
        - Clone the repository to `C:/cdh-vagrant/` which is accessible from `/mnt/c/cdh-vagrant/` in WSL
        - For more details check [Vagrant and Windows Subsystem for Linux](https://www.vagrantup.com/docs/other/wsl.html).
- Ideally 4 VMs with 8GB of RAM and 4 cores should work fine if you want to use more than the Essentials

## Installation Guide
- Clone this repository using `git clone https://github.com/frederickayala/cdh-vagrant.git`
    - If you are using Windows the repository must be cloned to a Windows drive path (e.g., `C:/cdh-vagrant` or `/mnt/c/cdh-vagrant`
- Go to the repository folder using `cd cdh-vagrant` 
- Append the lines in `append-to-hosts-file` to your hosts files. 
    - For MacOS, Linux, and WSL the file is located in `/etc/hosts`
    - For Windows the file is located in `C:\Windows\System32\Drivers\etc\hosts` 
    - Windows user must append the lines in both WSL and Windows. 
- Check the *HARDWARE NOTE* in the Vagrantfile to verify that matched your computer capabilities.
- Run the command `bash up.sh 3` this will start three VMs.
    - You can add up to 8 hosts. 
- If it is the first time that you are running vagrant run `vagrant init`
- SSH to the node `vagrant ssh c7401` the password is `vagrant`
- Switch to sudo using `sudo su -`
- Download CDH:
    - `wget https://archive.cloudera.com/cm6/6.2.0/cloudera-manager-installer.bin`
- Change the permissions:
    - `chmod u+x cloudera-manager-installer.bin`
- Run the Cloudera Manager Installer:
    - `./cloudera-manager-installer.bin`
    - Accept the terms and conditions
    - When the installation is finished you will see a message saying that you should open your Web browser to `http://c7401.cdh.testlab:7180/`

## Setting up the Cluster
- Open your browser and go to `http://c7401.cdh.testlab:7180/` if it does not work please check your hosts file or wait a couple of minutes for the process to start.
- The default username and password is `admin`
- Click `Continue` and accept the terms and conditions
- Select `Cloudera Express`, click `Continue`, and name your cluster `testlab`
- In `Specify Hosts` section write `c74[01-03].cdh.testlab` and click `Search`. If you are using more than 3 VMs modify accordingly. A list of the three hosts should appear saying `Host was successfully scanned.` Click `Continue`.
- Leave the `Select Repository` section as it is. Click `Continue`
- Select `Install Oracle Java SE Development Kit (JDK 8)` and click `Continue`
- In the `Enter Login Credentials` section:
    - In Authentication Method select: `All hosts accept same private key`
    - Click `File Upload`, Choose File, and select the `insecure_private_key` file from the repository folder.
    - Click `Continue`
- In the `Install Agents` section wait until the three agents say `Installation completed successfully` and click `Continue`
- In the `Install Parcels` section wait for the selected parcels to download, distribute, unpack, and activate.    
- In the `Inspect Cluster` section click `Inspect Network Performance` and `Inspect Hosts`. After both have the green mark select `
I understand the risks, let me continue with cluster creation.` and click `Continue`.
- In the `Select services` section you can pick the services that you want.
    - For example click custom services and select: HBase, HDFS, Hue, Spark, YARN (MR2 Included), Oozie, and ZooKeeper.
    - Note that 3 VMs is very little computing power for such services so choose only what you want to try.
- In the `Assign Roles`section you might need to select additional hosts for the services if there are warning. Click `Continue`
- In the `Setup Database` section ignore the warning about the embedded database, write down the passwords, and click `Test Connection`, then click `Continue`
- In `Review Changes` you might need to add additional configuration if there are warnings. Do so and click `Continue`. 
- **Note:** In `First Run Command` things might fail because of timeouts. We are running to much stuff in the same machine. It is usually enough to click `Resume`
    - It will take some time for this step to finish, you might also be logged out of Cloudera Manager. If this happens, refresh the window, login again using the `admin` password and username.
    - Again, if things fail is usually enough to click `Resume`
- Eventually you will see `Status  Finished`. Click on the `Cloudera Manager` logo or go to `http://c7401.cdh.testlab:7180/cmf/home`
- That's it, you can start using the services. 

## Cluster Ops
- SSH to a node: `vagrant ssh`
- Suspend the cluster: `vagrant suspend`
- Resume the cluster: `vagrant resume`
- To erase all the VMs: `vagrant destroy -f`
- Check the status of the VMs: `vagrant status`

## What next?
- We are will add exercises for the most common tools. Coming soon!