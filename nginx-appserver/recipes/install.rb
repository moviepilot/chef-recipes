include_recipe "application::default"

gem_package 'passenger' do
  version node[:nginx_appserver][:version]
end

execute "passenger_module" do
  command 'echo -en "\n1\n\n\n" | passenger-install-nginx-module'
end

[ :log_dir, :cache_dir, :config_dir, :vhost_dir ].each do |dir_name|
  directory node[:nginx_appserver][dir_name] do
    owner   node[:nginx_appserver][:user]
    mode    0755
    action  :create
  end
end

template "/etc/init.d/nginx" do
  source "init-script.erb"
  mode    0755
end

template "#{node[:nginx_appserver][:config_dir]}/nginx.conf" do
  source "nginx.conf.erb"
  owner  node[:nginx_appserver][:user]
  mode   0644
end

template "#{node[:nginx_appserver][:vhost_dir]}/site-moviepilot" do
  source "site-moviepilot.nginx.erb"
  owner  node[:nginx_appserver][:user]
  mode   0644
end

template "/etc/monit/conf.d/nginx_appserver.monitrc" do
  source "nginx.monitrc.erb"
  mode   0644
end

