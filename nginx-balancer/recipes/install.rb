# build dependencies for nginx
package "build-essential"
package "autotools-dev"
package "cvs"
package "debhelper"
package "dpatch"
package "gettext"
package "html2text"
package "intltool-debian"
package "libcroco3"
package "libmail-sendmail-perl"
package "libpcre3-dev"
package "libpcrecpp0"
package "libsys-hostname-long-perl"
package "patchutils"
package "po-debconf"
package "update-inetd"
# run dependencies for nginx
package "libpcre3"
package "libssl0.9.8"
package "zlib1g"


directory "/tmp/nginx_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/nginx_install/#{node[:nginx_balancer][:package_name]}" do
  source "#{node[:nginx_balancer][:package_url]}"
  mode "0644"
  action :create_if_missing
end

execute "untar nginx archive" do
 command "tar xzf #{node[:nginx_balancer][:package_name]}"
  cwd "/tmp/nginx_install"
end

execute "./configure --prefix=#{node[:nginx_balancer][:target_dir]} --with-http_ssl_module --with-http_realip_module --with-http_stub_status_module && make && make install" do
  cwd "/tmp/nginx_install/nginx-#{node[:nginx_balancer][:version]}"
end

execute "rm #{node[:nginx_balancer][:link_dir]}" do
  only_if "test -L #{node[:nginx_balancer][:link_dir]}"
end

execute "ln -fs #{node[:nginx_balancer][:target_dir]} #{node[:nginx_balancer][:link_dir]}" do
  cwd "/opt"
end

execute "ln -fs #{node[:nginx_balancer][:link_dir]}/conf /etc/nginx" do
  cwd "/opt"
end

template "/etc/init.d/nginx" do
  source "init-script.erb"
  owner "root"
  group "root"
  mode "0755"
end

execute "update-rc.d nginx defaults" do
  cwd "/"
end

execute "mkdir -p /var/log/nginx" do
  cwd "/"
end

execute "mkdir -p /etc/nginx/sites-enabled" do
  cwd "/"
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
end

template "/etc/nginx/sites-enabled/default-site" do
  source "default-site.erb"
end
