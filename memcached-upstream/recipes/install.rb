package "libevent-dev" do
  action :install
end

directory "/tmp/memcached-upstream_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/memcached-upstream_install/#{node[:memcached_upstream][:package_name]}" do
  source "#{node[:memcached_upstream][:upstream_url]}"
  mode "0644"
  action :create_if_missing
end

execute "untar memcached-upstream archive" do
 command "tar xvfz #{node[:memcached_upstream][:package_name]}"
  cwd "/tmp/memcached-upstream_install"
end

execute "./configure --prefix=#{node[:memcached_upstream][:install_dir]} && make && make install" do
  cwd "/tmp/memcached-upstream_install/memcached-#{node[:memcached_upstream][:version]}"
end

execute "rm /opt/memcached-upstream" do
  only_if "test -L /opt/memcached-upstream"
end

execute "ln -s #{node[:memcached_upstream][:install_dir]} /opt/memcached-upstream" do
  cwd "/opt"
end

directory "#{node[:memcached_upstream][:log_dir]}" do
  owner node[:memcached_upstream][:user]
  mode "0755"
  action :create
end

template "/etc/init.d/memcached-upstream" do
  source "init-script.erb"
  owner "root"
  group "root"
  mode "0755"
end

template "/etc/memcached-upstream.conf" do
  source "memcached-upstream.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/monit/conf.d/memcached-upstream.monitrc" do
  source "memcached-upstream.monitrc.erb"
  owner "root"
  group "root"
  mode  "0644"
end

template "/opt/memcached-upstream/bin/start-memcached" do
  source "start-memcached.erb"
  owner "root"
  group "root"
  mode  "0755"
end

execute "update-rc.d memcached-upstream defaults" do
  cwd "/"
end

execute "monit monitor memcached-upstream"

