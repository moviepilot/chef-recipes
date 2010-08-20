directory "/tmp/nginx_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/nginx_install/#{node[:nginx][:package_name]}" do
  source "#{node[:nginx][:package_url]}"
  mode "0644"
  action :create_if_missing
end

execute "untar nginx archive" do
 command "tar xzf #{node[:nginx][:package_name]}"
  cwd "/tmp/nginx_install"
end

execute "./configure --prefix=#{node[:nginx][:target_dir]} --with-http_ssl_module --with-http_realip_module --with-http_stub_status_module && make && make install" do
  cwd "/tmp/nginx_install/nginx-#{node[:nginx][:version]}"
end

execute "rm #{node[:nginx][:link_dir]}" do
  only_if "test -L #{node[:nginx][:link_dir]}"
end

execute "ln -s #{node[:nginx][:target_dir]} #{node[:nginx][:link_dir]}" do
  cwd "/opt"
end

execute "ln -s #{node[:nginx][:link_dir]}/conf /etc/nginx" do
  cwd "/opt"
end

