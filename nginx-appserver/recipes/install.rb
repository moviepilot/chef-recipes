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

include_recipe "application::default"

gem_package 'bundler' do
  gem_binary "#{node[:nginx_appserver][:ruby_path]}/bin/gem"
  version node[:nginx_appserver][:bundler_version]
end

gem_package 'passenger' do
  gem_binary "#{node[:nginx_appserver][:ruby_path]}/bin/gem"
  version node[:nginx_appserver][:version]
end

execute "passenger_module" do
  command "#{node[:nginx_appserver][:ruby_path]}/bin/passenger-install-nginx-module --auto --auto-download --prefix=#{node[:nginx_appserver][:root_dir]}"
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

template "/etc/monit/conf.d/nginx_appserver.monitrc" do
  source "nginx.monitrc.erb"
  mode   0644
end

