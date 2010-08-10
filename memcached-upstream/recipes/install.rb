package "libevent-dev" do
  action :install
end

directory "/tmp/memcached-upstream_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/memcached-upstream_install/#{node[:memcached_upstream][:package_name]}" do
  source "http://memcached.googlecode.com/files//#{node[:memcached_upstream][:upstream_url]}"
  mode "0644"
  action :create_if_missing
end

execute "untar memcached-upstream archive" do
 command "tar xvfz #{node[:memcached_upstream][:package_name]}"
  cwd "/tmp/memcached-upstream_install"
end

execute "./configure --prefix=#{node[:memcached_upstream][:install_dir]} && make && make install" do
  cwd "/tmp/memcached-upstream_install/memcached-upstream-#{node[:memcached_upstream][:version]}"
end

execute "rm /opt/memcached-upstream" do
  only_if "test -L /opt/memcached-upstream"
end

execute "ln -s #{node[:memcached_upstream][:install_dir]} /opt/memcached-upstream" do
  cwd "/opt"
end


