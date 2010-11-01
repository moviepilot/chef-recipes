include_recipe 'scalper::install'
include_recipe 'ruby19::install'

package 'libxml2'
package 'libxml2-dev'
package 'libxslt1.1' 
package 'libxslt1-dev'
package 'libcurl4-openssl-dev'

template "/root/.bashrc" do
  source "bashrc.erb"
  owner "root"
  group "root"
  mode  "0644"
end

template "/home/ubuntu/.bashrc" do
  source "bashrc.erb"
  owner "ubuntu"
  group "ubuntu"
  mode  "0644"
end
