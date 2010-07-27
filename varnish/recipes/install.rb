package "libmysql++-dev" do
  action :install
end

directory "/tmp/varnish_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/varnish_install/#{node[:varnish][:package_name]}" do
#  source "http://www.varnishsearch.com/downloads/#{node[:varnish][:package_name]}"
  source "http://downloads.sourceforge.net/project/varnish/varnish/2.1.2/varnish-2.1.2.tar.gz?use_mirror=ovh&ts=1280224361"
  mode "0644"
  action :create_if_missing
end

execute "untar varnish archive" do
 # command "tar xvfz #{node[:varnish][:package_name]}"
 command "tar xvfz varnish-2.1.2.tar.gz"
  cwd "/tmp/varnish_install"
end

execute "./configure --with-mysql && make && make install" do
#  cwd "/tmp/varnish_install/varnish-#{node[:varnish][:version]}"
  cwd "/tmp/varnish_install/varnish-2.1.2"
end

