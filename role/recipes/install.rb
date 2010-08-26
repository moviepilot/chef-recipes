include_recipe 'scalper::install'
include_recipe 'ruby19::install'

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
