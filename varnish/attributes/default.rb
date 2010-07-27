default[:varnish] = {}
default[:varnish][:version] = '0.9.9'
default[:varnish][:package_name] = "varnish-#{node[:varnish][:version]}.tar.gz"
default[:varnish][:memory_limit] = "256M"
default[:varnish][:cron_interval] = 10
default[:varnish][:port] = 9312
