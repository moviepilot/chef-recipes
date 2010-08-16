default[:nginx_appserver] = {}
default[:nginx_appserver][:version]        = '2.2.15'
default[:nginx_appserver][:ruby_path]      = '/opt/ruby'
#default[:nginx_appserver][:passenger_root] = "#{`gem environment gemdir`.strip}/gems/passenger-#{default[:nginx_appserver][:version]}"
default[:nginx_appserver][:passenger_root] = "#{`#{default[:nginx_appserver][:ruby_path]}/bin/gem environment gemdir`.strip}/gems/passenger-#{default[:nginx_appserver][:version]}"
default[:nginx_appserver][:user]           = 'www-data'
default[:nginx_appserver][:root_dir]       = '/opt/nginx'
default[:nginx_appserver][:cache_dir]      = '/var/cache/nginx'
default[:nginx_appserver][:config_dir]     = '/etc/nginx'
default[:nginx_appserver][:default_config] = '/etc/nginx/nginx.conf'
default[:nginx_appserver][:vhost_dir]      = '/etc/nginx/sites-enabled'
default[:nginx_appserver][:pid_file]       = '/var/run/nginx.pid'
default[:nginx_appserver][:log_dir]        = '/var/log/nginx'
default[:nginx_appserver][:error_log]      = '/var/log/nginx/error.log'
default[:nginx_appserver][:port]           = '80'
#{`gem environment gemdir`.strip}
