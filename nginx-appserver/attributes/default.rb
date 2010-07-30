default[:nginx_appserver] = {}
default[:nginx_appserver][:version]   = '2.2.15'
default[:nginx_appserver][:user]      = 'www-data'
default[:nginx_appserver][:root_dir]  = '/opt/nginx'
default[:nginx_appserver][:pid_file]  = '/var/run/nginx.pid'
default[:nginx_appserver][:log_dir]   = '/var/log/nginx'
default[:nginx_appserver][:error_log] = '/var/log/nginx/error.log'