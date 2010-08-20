package "libmysql++-dev" do
  action :install
end

directory "/tmp/ruby19_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/ruby19_install/#{node[:ruby19][:package_name]}" do
  source "#{node[:ruby19][:package_url]}"
  mode "0644"
  action :create_if_missing
end

execute "untar ruby19 archive" do
 command "tar xjf #{node[:ruby19][:package_name]}"
  cwd "/tmp/ruby19_install"
end

execute "./configure --prefix=#{node[:ruby19][:target_dir]} && make && make install" do
  cwd "/tmp/ruby19_install/ruby-#{node[:ruby19][:version]}"
end

execute "rm #{node[:ruby19][:link_dir]}" do
  only_if "test -L #{node[:ruby19][:link_dir]}"
end

execute "ln -s #{node[:ruby19][:target_dir]} #{node[:ruby19][:link_dir]}" do
  cwd "/opt"
end

execute "#{node[:ruby19][:link_dir]}/bin/gem update --system" do
  cwd "#{node[:ruby19][:link_dir]}"
end

execute "set environment vars" do
  command 'echo PATH="#{default[:ruby19][:link_dir]}/lib/ruby/gems/#{default[:ruby19][:gems_version]}/bin/:#{default[:ruby19][:link_dir]}/bin/:$PATH"'
end
