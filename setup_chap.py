from fabric.api import *
username = prompt('Please specify your pptp username: ')
password = prompt('Please specify your pptp password: ')
secret = '%s pptpd %s *' % (username, password)
local('sudo echo %s >> ./chap-secrets')
