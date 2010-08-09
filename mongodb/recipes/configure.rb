include_recipe "deploy" # get the deployment attributes

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping redis::configure as application #{application} as it is not an Rails app")
    next
  end
  
  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command "touch tmp/restart.txt"
    action :nothing
  end
  
   mongo_server = node[:scalarium][:roles][:mongodb][:instances].keys.first rescue nil
 
  

  execute "create config directory" do
    command "mkdir -p #{node[:mongodb][:mongodb_config].gsub(/\/[^\/]+$/, '')}" 
  end

  template "#{node[:mongodb][:mongodb_config]}" do
    only_if do
      File.directory?("#{deploy[:deploy_to]}/current") && mongo_server
    end
    source "database.mongo.yml.erb"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables :host => node[:scalarium][:roles][:mongodb][:instances][mongo_server][:private_dns_name],
              :port => node[:mongodb][:port],
              :database => application
    
    notifies :run, resources(:execute => "restart Rails app #{application}")
    
  end
end
