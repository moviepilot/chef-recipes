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
  
   memcached_upstream_server = node[:scalarium][:roles][:memcached_upstream][:instances].keys.first rescue nil
 
  next unless memcached_upstream_server  # don't abort if we don't have a memcached_upstream instance running yet
  

  execute "create config directory" do
    command "mkdir -p #{node[:memcached_upstream][:memcached_upstream_config].gsub(/\/[^\/]+$/, '')}" 
  end

  template "#{node[:memcached_upstream][:memcached_upstream_config]}" do
    only_if do
      File.directory?("#{deploy[:deploy_to]}/current") && memcached_upstream_server
    end
    source "database.memcached_upstream.yml.erb"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables :host => node[:scalarium][:roles][:memcached_upstream][:instances][memcached_upstream_server][:private_dns_name],
              :port => node[:memcached_upstream][:port]
    
    notifies :run, resources(:execute => "restart Rails app #{application}")
    
  end
end
