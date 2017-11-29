
# configure OS user and groups
default['tomcat']['user'] = 'tomcat'
default['tomcat']['group'] = 'tomcat'

# tomcat configs
default['tomcat']['version'] = '8.0.33' # Semantic versioning
default['tomcat']['path'] = '/opt/tomcat'

default['tomcat']['port'] = '8080'
