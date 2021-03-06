package "libreadline-dev" do
  action :install
end

package "libncurses5-dev" do
  action :install
end

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
  command "sed -i -e 's%\\(PATH=\\)%\\1#{node[:ruby19][:link_dir]}/lib/ruby/gems/#{node[:ruby19][:gems_version]}/bin/:#{node[:ruby19][:link_dir]}/bin/:%g' -e 's/\"//g' /etc/environment"

end


