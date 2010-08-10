include_recipe "deploy" # get the deployment attributes
include_recipe "redis"

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
  
  redis_server = node[:scalarium][:roles][:redis][:instances].keys.first rescue nil

  next unless redis_server  # don't abort if we don't have a redis instance running yet
  
  execute "create config directory" do
    command "mkdir -p #{node[:resque][:resque_config].gsub(/\/[^\/]+$/, '')}"
  end

  template node[:resque][:resque_config] do
    source "resque.yml.erb"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables :host => node[:scalarium][:roles][:redis][:instances][redis_server][:private_dns_name],
              :deploy => deploy,
              :application => application
    
    if deploy[:stack][:needs_reload]
      notifies :run, resources(:execute => "restart Rails app #{application}")
    end
    
    only_if do
      File.directory?("#{deploy[:deploy_to]}/current")
    end
  end
end
