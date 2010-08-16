default[:ruby19] = {}
default[:ruby19][:version] = '1.9.1-p429'
default[:ruby19][:package_name] = "ruby-#{node[:ruby19][:version]}.tar.bz2"
default[:ruby19][:package_url] = "http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/#{node[:ruby19][:package_name]}"
default[:ruby19][:target_dir] = "/opt/ruby-#{node[:ruby19][:version]}"
default[:ruby19][:link_dir] = "/opt/ruby"

