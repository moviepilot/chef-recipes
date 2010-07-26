default[:nginx] = {}
default[:nginx][:version] = '0.8.7'
default[:nginx][:package_name] = "nginx-#{node[:nginx][:version]}.tar.gz"
default[:nginx][:memory_limit] = "256M"
default[:nginx][:cron_interval] = 10
default[:nginx][:port] = 9312
