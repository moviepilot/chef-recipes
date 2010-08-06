include_recipe "deploy" # get the deployment attributes

node[:deploy].each do |application, deploy|
  execute "create config directory" do
    command "mkdir -p #{node[:raisin][:config_file].gsub(/\/[^\/]+$/, '')}"
  end

  raisin_server = node[:scalarium][:roles][:raisin][:instances].keys.first


  template "#{node[:raisin][:config_file]}" do
    source "raisin.yml.erb"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables :host => node[:scalarium][:roles][:raisin][:instances][raisin_server][:private_dns_name],
              :port => node[:raisin][:port],
    
    notifies :run, resources(:execute => "restart Rails app #{application}")
    
    only_if do
      File.directory?("#{deploy[:deploy_to]}/current")
    end
  end
end
