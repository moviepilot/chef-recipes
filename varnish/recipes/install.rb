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

execute "./configure && make && make install" do
  cwd "/tmp/varnish_install/varnish-#{node[:varnish][:version]}"
end

