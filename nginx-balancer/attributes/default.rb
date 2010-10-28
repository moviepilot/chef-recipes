default[:nginx_balancer] = {}
default[:nginx_balancer][:version] = '0.7.67'
default[:nginx_balancer][:package_name] = "nginx-#{node[:nginx_balancer][:version]}.tar.gz"
default[:nginx_balancer][:package_url] = "http://nginx.org/download/#{node[:nginx_balancer][:package_name]}"
default[:nginx_balancer][:target_dir] = "/opt/nginx-#{node[:nginx_balancer][:version]}"
default[:nginx_balancer][:link_dir] = "/opt/nginx"
default[:nginx_balancer][:pid_file]       = '/var/run/nginx.pid'
default[:nginx_balancer][:port]           = '80'
default[:nginx_balancer][:config]         = 'pen'

