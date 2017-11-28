# Instructions
This cookbook was created to answer the (challenge-configure-tomcat)[https://learn.chef.io/modules/challenge-configure-tomcat#/]. The below shows how this cookbook was created:
- Install latest (chefdk)[https://downloads.chef.io/chefdk] *Note: Mac OS X/macOS 10.13 is not available yet
- create public repo on (github)[https://github.com/salimkapadia/challenge-configure-tomcat.git]
- git clone https://github.com/salimkapadia/challenge-configure-tomcat.git
- change directory `cd challenge-configure-tomcat.git`
- `touch README.md`
- `chef generate app workshop-repo`
- `chef generate cookbook workshop-repo/cookbooks/tomcat`
- `chef generate recipe workshop-repo/cookbooks/tomcat server`
- `cd workshop-repo/cookbooks/tomcat`

- Vagrant: Project Setup: `vagrant init`
- Vagrant: Installing a Box: `vagrant box add bento/centos-7.2`
- Vagrant: bring up VM: `vagrant up`
