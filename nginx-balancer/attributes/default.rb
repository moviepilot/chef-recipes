default[:nginx] = {}
default[:nginx][:version] = '0.7.67'
default[:nginx][:package_name] = "nginx-#{node[:nginx][:version]}.tar.gz"
default[:nginx][:package_url] = "http://nginx.org/download/#{node[:nginx][:package_name]}"
default[:nginx][:target_dir] = "/opt/nginx-#{node[:nginx][:version]}"
default[:nginx][:link_dir] = "/opt/nginx"

