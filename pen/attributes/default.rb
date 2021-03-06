default[:pen] = {}
default[:pen][:version]        = '0.18.0'
default[:pen][:user]           = 'pen'
default[:pen][:port]           = '8080'
default[:pen][:pid_file]       = "/var/run/pen-#{node[:pen][:port]}.pid"
default[:pen][:log_dir]        = '/var/log/pen'
default[:pen][:package_name]   = "pen-#{node[:pen][:version]}.tar.gz"
default[:pen][:package_url]    = "http://siag.nu/pub/pen/#{node[:pen][:package_name]}"
default[:pen][:target_dir]     = "/opt/pen-#{node[:pen][:version]}"
default[:pen][:link_dir]       = "/opt/pen"
