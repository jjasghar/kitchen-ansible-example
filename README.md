# kitchen-ansible-example

kitchen-ansible-example for testing ansible using [test kitchen][kitchen] and [Inspec][inspec].

This demonstrates using test-kitchen, ansible and inspec to build and verify a tomcat server.
  * Everything is done via ssh from the Ansible/Inspec server so nothing is installed on the tomcat server apart from Java and Tomcat.
  * In this demonstration both servers are centos 6.5 running under virtual box on your workstation, however the Tomcat server
could be anywhere like Amazon EC2, or a Docker Container.
  * You can take an image of the server after it is build and no comfiguration software is install on the Tomcat Server.
  * this is using ansible in ssh connection mode to do remote configuration.

## Workstation Software Installation

The first thing you need to do is install the test-kitchen environment on your workstation.
A useful link is: http://misheska.com/blog/2013/12/26/set-up-a-sane-ruby-cookbook-authoring-environment-for-chef/

The follow instructions are for Windows PC (it will be similar for Mac):

1. Download and install virtualbox from https://www.virtualbox.org/wiki/Downloads.
2. Download and install Vagrant from https://www.vagrantup.com/downloads.html
3. Download and install the Windows RubyInstaller for 64 bit Ruby 2.1 from http://rubyinstaller.org/downloads.
   * Check the option to add ruby to your path.
4. Download and install the Windows Ruby DevKit for use with Ruby 2.0 and above (64bits version only) from http://rubyinstaller.org/downloads.
5. Configure the Ruby DevKit
   * In the devkit directory run “ruby dk.rb init”.
   * Check the config.yml generated has added the the path of the ruby install, if not add it manaully.
   * run “ruby dk.rb install” to bind it to the ruby installation.
6. git clone the repository https://github.com/jjasghar/kitchen-ansible-example and in a command window in the kitchen-ansible-example directory run command
7. Run `bundle install`
8. Run `bundle exec kitchen list` to validate everything is setup
8. Run `bundle exec kitchen verify` to see it in action

```
kitchen list
```

This will return a list if everything is correctly installed.

There are 2 ways to run ansible either locally or remotely. In the local option you just need one server and ansible and the software you are configuring are all installed on the one server.
In the remote option you need at least 2 servers. One server will get ansible installed on it and it will then use ssh to configure the second server remotely.

When using rename spec/spec_helper_local.rb to spec/spec_helper.rb and a separate tomcat servers is not required.

```
kitchen create ansible-centos-65 -l debug
kitchen converge ansible-centos-65 -l debug
kitchen verify ansible-centos-65 -l debug
```

## Create Servers in Vagrant on your Workstation.

1. Review the .kitchen.yml file, specifying IP address that are part of your workstation private address space or
use DHCP to let the network dynamically allocte IP addresses.

2. To bring servers up using DHCP on your workstation run
```
kitchen create ansible-centos-65 -l debug
kitchen create tomcat-centos-65 -l debug
```
2. So ansible can access the server get the “private_key” file of the tomcat servers from directory
  kitchen-ansible-example/.kitchen/kitchen-vagrant/kitchen-kitchen-ansible-example-tomcat-centos-65/.vagrant/machines/default/virtualbox/private_key
and copy to
  kitchen-ansible-example/spec/tomcat_private_key.pem
3. Update the hosts file with the  IP address of the tomcat server.

## Build the tomcat server.
```
kitchen converge ansible-centos-65 -l debug
```

## Verify the tomcat server.
```
kitchen verify ansible-centos-65 -l debug
```

[kitchen]: http://kitchen.ci
[inspec]: http://github.com/chef/inspec
