gem_package 'resque' do
  version node[:resque][:version]
end

service "monit" do
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

template "/etc/monit/monitrc" do
  source "monitrc.erb"
  mode 0644
  notifies :restart, resources(:service => "monit")
end

service "monit" do
  action :restart
end

template '/usr/local/sbin/resquectl' do
  source 'resquectl.erb'
  mode 0755
  owner 'root'
  group 'root'
end
