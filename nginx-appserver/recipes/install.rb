gem_package 'passenger' do
  version node[:resque][:version]
end

execute "passenger_module" do
  command 'echo -en "\n1\n\n\n" | passenger-install-nginx-module'
end

directory "#{node[:nginx_appserver][:log_dir]}" do
  owner   node[:nginx_appserver][:user]
  mode    0755
  command :create_if_not_exists
end

template "init-script" do
  path   "/etc/init.d/nginx"
  source "init-script.erb"
  owner  "root"
  group  "root"
  mode    0644
end

template "nginx-config" do
  
end