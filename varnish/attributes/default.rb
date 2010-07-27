default[:varnish] = {}
default[:varnish][:version] = '2.1.2'
default[:varnish][:package_name] = "varnish-#{node[:varnish][:version]}.tar.gz"
default[:varnish][:memory_limit] = "256M"
default[:varnish][:port] = 9312
