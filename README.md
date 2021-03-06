# puppet-control-repo

## Table of Contents

1. [Building a Learning Puppet Code Repository](#building-a-learning-environent)
2. [Install Code Manager](#install-code-manager)
3. [Use PuppetFile for module loads](#use-puppetFile-for-module-loads)
4. [Roles and Profiles](#roles-profiles)
5. [Repository Roles](#repository-roles)

## Building a Learning Puppet Environment
This project began as a plan to build an environment for demoing different facets of Puppet Enterprise.  The Repository allows you to spin up a monolithic Puppet Enterprise Console, and a series of agents quickly.  The environment is best supported by using templates of Redhat/Ubuntu Linux or Windows Server 2012R2/2016.

## Install Code Manager
Code Manager requires you to configure both the PE console to define the Code Manager repository, and setup the client tools on your MAC.  Puppet documentation takes care of walking you through the steps:

1. Create a control repository for maintaining your environments and code.  Code management in PE uses your existing Git repository (repo) branches to create environments. Environments allow you to designate a node or node group to use a specific environment. For example, you could designate one node group to use the development environment and another to use the production environment. As you update the code in your control repo, code management tracks the state of that repo to keep each environment updated.

2. Set up Puppetfiles to manage content in your environments.  Puppetfiles specify which modules and data to install in your environments, including what version of that content should be installed, and where Puppet should get it.

3. Configure Code Manager (recommended) or r10k.  Configure Code Manager or r10k in the console’s master profile. If you need to customize your configuration further, you can do so by adding keys to Hiera. See the Code Manager or r10k pages for configuration instructions.

4. Set up a deployment trigger to run Code Manager automatically. You can also trigger Code Manager manually from the command line. If you are using r10k alone, you’ll continue to run it manually from the command line whenever you want to deploy. See the Code Manager or r10k pages for information about triggering Code Manager or running r10k.

5. When you are ready to run Puppet and enforce code changes on your nodes, whether on just a few nodes for testing or on a larger set, use the Puppet orchestrator command line tool.

Code Manager Setup:  https://docs.puppet.com/pe/latest/cmgmt_managing_code.html

Github (Example Repository): https://github.com/puppetlabs/control-repo

##Use PuppetFile for module loads

The Puppetfile loads all required modules to support the Code Manager deployment.  PuppetFile references both direct load of puppet forge modules or may load module code directly from github.  The code snippet below shows an example module load.

forge "http://forge.puppetlabs.com"

# Modules from the Puppet Forge
# Versions should be updated to be the latest at the time you start
mod "puppetlabs/stdlib", :latest
mod "puppetlabs/concat", :latest

During staging, Code Manager make a copy of all puppet code from your repository and preloads all the modules defined by the PuppetFile.  Once the staging completes, the modules push to the specified environments.  Any node classification using the deployed environment is applied during the next puppet agent run.

##Roles and Profiles

Roles provides an abstracted view of a set of profile configuration.  Typically a role aligns to a specific client
or node.  The role integrates a series of profile to build a client.  An example of a application role would include: base os/security profile, web servers, and database server.

Profiles abstract attributes of client configuration.  A profile normally uses module to build a set of resources aligned to the same purpose.  For example, a profile might load a pair of modules to install nginx and migrate its base htdoc location to a different folder.

##Repository Roles

The repository supports a series of demonstration roles allowing quick setup and configuration.  I am updating the repository frequently.

1. iis - base iis installation with relocation of docroot
2. jenkins - jenkins server with integrated PE plug-in to support building pipelines for puppet deployment
3. linux - baseline linux configuration which includes account, time, and firewall.
4. print - CUPS server setup for basic printing over the network
5. unifi - unifi Server for managing Ubiquiti firewall, wap, and switches
6. linux - baseline windows configuration which includes account, time, and firewall.

@cdrobey
