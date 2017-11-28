# Instructions
The below shows how this cookbook was created:
- Install latest (chefdk)[https://downloads.chef.io/chefdk] *Note: Mac OS X/macOS 10.13 is not available yet
- create public repo on (github)[https://github.com/salimkapadia/challenge-configure-tomcat.git]
- git clone https://github.com/salimkapadia/challenge-configure-tomcat.git
- change directory into it `cd challenge-configure-tomcat.git`
- `touch README.md`
- `chef generate app workshop-repo`
- `chef generate cookbook workshop-repo/cookbooks/tomcat`
- `chef generate recipe workshop-repo/cookbooks/tomcat server`
