package "libmysql++-dev" do
  action :install
end

directory "/tmp/mongodb_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/mongodb_install/#{node[:mongodb][:package_name]}" do
  source "http://fastdl.mongodb.org/linux/#{node[:mongodb][:package_name]}"
  mode "0644"
  action :create_if_missing
end

execute "untar mongodb archive" do
 command "tar xvfz #{node[:mongodb][:package_name]}"
  cwd "/tmp/mongodb_install"
end

execute "mv /tmp/mongodb_install/#{node[:mongodb][:package_name]} /opt/#{node[:mongodb][:package_name]} " do
  cwd "/tmp/mongodb_install/mongodb-#{node[:mongodb][:version]}"
end

execute "ln -s /opt/#{node[:mongodb][:package_name]} /opt/mongodb" do
  cwd "/opt"
end

