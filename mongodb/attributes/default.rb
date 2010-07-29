default[:mongodb] = {}
default[:mongodb][:version]      = '1.4.4'
default[:mongodb][:arch]         = `uname -m`.strip
default[:mongodb][:dir_name]     = "mongodb-linux-#{node[:mongodb][:arch]}-#{node[:mongodb][:version]}"
default[:mongodb][:package_name] = "mongodb-linux-#{node[:mongodb][:arch]}-#{node[:mongodb][:version]}.tgz"
default[:mongodb][:db_directory] = '/var/lib/mongodb'
default[:mongodb][:pidfile]      = '/var/run/mongod.pid'
default[:mongodb][:port]         = "27017"
