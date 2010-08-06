include_recipe "deploy"

node[:deploy].each do |application, deploy|
  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command "touch tmp/restart.txt"
    action :nothing
  end
 
  solr_server = node[:scalarium][:roles][:solr][:instances].collect{|instance, names| names["private_dns_name"]}.first

  execute "create config directory" do
    command "mkdir -p #{node[:sunspot_solr][:discovery_config].gsub(/\/[^\/]+$/, '')}"
  end

  template "#{node[:sunspot_solr][:discovery_config]}" do
    source "discovery.yml.erb"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables :host => solr_server

    if deploy[:stack][:needs_reload]
      notifies :run, resources(:execute => "restart Rails app #{application}")
    end
    
    only_if do
      File.directory?("#{deploy[:deploy_to]}/current")
    end
  end
end
