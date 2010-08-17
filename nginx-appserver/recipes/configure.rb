node[:nginx_appserver][:passenger_root] = "#{`#{node[:nginx_appserver][:ruby_path]}/bin/gem environment gemdir`.strip}/gems/passenger-#{node[:nginx_appserver][:version]}"

template "#{node[:nginx_appserver][:config_dir]}/nginx.conf" do
  source "nginx.conf.erb"
  owner  node[:nginx_appserver][:user]
  mode   0644
end

