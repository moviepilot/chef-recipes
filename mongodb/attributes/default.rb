default[:mongodb] = {}
default[:mongodb][:version] = '1.4.4'
default[:mongodb][:package_name] = "mongodb-linux-i686-#{node[:mongodb][:version]}.tar.gz"
