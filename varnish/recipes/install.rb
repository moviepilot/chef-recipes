package "autoconf"
package "automake1.9"
package "autotools-dev"
package "cvs"
package "debhelper"
package "diffstat"
package "gettext"
package "html2text"
package "intltool-debian"
package "libcroco3"
package "libltdl-dev"
package "libltdl7"
package "libmail-sendmail-perl"
package "libncurses5-dev"
package "libpcre3"
package "libpcre3-dev"
package "libsys-hostname-long-perl"
package "libtool"
package "libxslt1.1"
package "m4"
package "pkg-config"
package "po-debconf"
package "quilt"
package "update-inetd"
package "xsltproc"


directory "/tmp/varnish_install" do
  mode "0755"
  action :create
end

remote_file "/tmp/varnish_install/#{node[:varnish][:package_name]}" do
  source "http://downloads.sourceforge.net/project/varnish/varnish/#{node[:varnish][:version]}/varnish-#{node[:varnish][:version]}.tar.gz?use_mirror=ovh&ts=1280224361"
  mode "0644"
  action :create_if_missing
end

execute "untar varnish archive" do
 command "tar xvfz #{node[:varnish][:package_name]}"
  cwd "/tmp/varnish_install"
end

execute "./configure --prefix=#{node[:varnish][:target_dir]} && make && make install" do
  cwd "/tmp/varnish_install/varnish-#{node[:varnish][:version]}"
end

execute "rm #{node[:varnish][:link_dir]}" do
  only_if "test -L #{node[:varnish][:link_dir]}"
end

execute "ln -s #{node[:varnish][:target_dir]} #{node[:varnish][:link_dir]}" do
  cwd "/opt"
end

template "/etc/init.d/varnish" do
  source "init-script.erb"
  owner "root"
  group "root"
  mode "0755"
end

execute "update-rc.d varnish defaults" do
  cwd "/"
end

template "/etc/monit/conf.d/varnish.monitrc" do
  source "varnish.monitrc.erb"
  owner "root"
  group "root"
  mode  "0644"
end

execute "mkdir -p /etc/varnish" do
   cwd "/"
end

template "/etc/varnish/default.vcl" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode  "0644"
end

template "/etc/default/varnish" do
  source "varnish-default.erb"
  owner "root"
  group "root"
  mode  "0644"
end

template "/etc/default/varnishlog" do
  source "varnishlog-default.erb"
  owner "root"
  group "root"
  mode  "0644"
end

template "/etc/default/varnishncsa" do
  source "varnishncsa-default.erb"
  owner "root"
  group "root"
  mode  "0644"
end


execute "chown -R #{node[:varnish][:user]}:#{node[:varnish][:group]}  #{node[:varnish][:link_dir]}/var/varnish" do
  action :run
end

execute "monit reload && monit restart varnish" do
  action :run
end



