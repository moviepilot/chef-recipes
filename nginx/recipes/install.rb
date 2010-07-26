#package "libmysql++-dev" do
#  action :install
#end

#directory "/tmp/sphinx_install" do
#  mode "0755"
#  action :create
#end

remote_file "/tmp/nginx-0.7.67.tar.gz" do
        source "http://nginx.org/download/nginx-0.7.67.tar.gz"
  mode "0644"
  action :create_if_missing
end


execute "untar nginx archive" do
  command "tar xfz /tmp/nginx-0.7.67.tar.gz"
  cwd "/tmp"
end

execute "./configure && make && make install" do
  cwd "/tmp/nginx-0.7.67"
end
