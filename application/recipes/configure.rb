include_recipe "deploy" # get the deployment attributes
include_recipe "nginx-appserver" # get the nginx attributes

Chef::Log.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
Chef::Log.debug(node)
Chef::Log.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

#node[:deploy].each do |application, deploy|
#  if deploy[:application_type] != 'rails'
#    next
#  end
#  
#  #-template "#{node[:nginx_appserver][:vhost_dir]}/site-moviepilot" do
#  #  -  source "site-moviepilot.nginx.erb"
#  #  -  owner  node[:nginx_appserver][:user]
#  #  -  mode   0644
#  #  -end
#   
#
#
#  #template "
#  #"#{deploy[:deploy_to]}/current/config/database.mongo.yml" 
#  #  source "database.mongo.yml.erb"
#  #  mode "0660"
#  #  group deploy[:group]
#  #  owner deploy[:user]
#  #  variables :host => node[:scalarium][:roles][:mongodb][:instances][mongo_server][:private_dns_name],
#  #            :port => node[:mongodb][:port],
#  #            :database => application
#  #  
#  #  notifies :run, resources(:execute => "restart Rails app #{application}")
#  #  
#  #  only_if do
#  #    File.directory?("#{deploy[:deploy_to]}/current")
#  #  end
#  #end
#
#end
