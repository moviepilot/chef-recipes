default[:varnish] = {}
default[:varnish][:version] = '2.1.2'
default[:varnish][:package_name] = "varnish-#{node[:varnish][:version]}.tar.gz"
default[:varnish][:memory_limit] = "256M"
default[:varnish][:port] = 9312
default[:varnish][:target_dir]     = "/opt/varnish-#{node[:varnish][:version]}"
default[:varnish][:link_dir]       = "/opt/varnish"
