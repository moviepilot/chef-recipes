directory "/tmp/pen_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/pen_install/#{node[:pen][:package_name]}" do
  source "#{node[:pen][:package_url]}"
  mode "0644"
  action :create_if_missing
end

execute "untar pen archive" do
 command "tar xzf #{node[:pen][:package_name]}"
  cwd "/tmp/pen_install"
end

execute "./configure --prefix=#{node[:pen][:target_dir]} && make && make install" do
  cwd "/tmp/pen_install/pen-#{node[:pen][:version]}"
end

execute "rm #{node[:pen][:link_dir]}" do
  only_if "test -L #{node[:pen][:link_dir]}"
end

execute "ln -s #{node[:pen][:target_dir]} #{node[:pen][:link_dir]}" do
  cwd "/opt"
end

template "/etc/init.d/pen" do
  source "init-script.erb"
  owner "root"
  group "root"
  mode "0755"
end

execute "update-rc.d pen defaults" do
  cwd "/"
end

