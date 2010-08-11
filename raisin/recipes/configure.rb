require 'rubygems'
require 'json'
include_recipe "deploy" # get the deployment attributes


node[:deploy].each do |application, deploy|
  execute "create config directory" do
    command "mkdir -p #{node[:raisin][:config_file].gsub(/\/[^\/]+$/, '')}"
  end

  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command "touch tmp/restart.txt"
    action :nothing
  end


  cluster_state = JSON.load( File.read("/var/lib/scalarium/cluster_state.json") )

  next unless cluster_state["roles"]["raisin"]["instances"].first.last["private_dns_name"]

  template "#{node[:raisin][:config_file]}" do
    source "raisin.yml.erb"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables :host => cluster_state["roles"]["raisin"]["instances"].first.last["private_dns_name"],
              :port => node[:raisin][:port]

    notifies :run, resources(:execute => "restart Rails app #{application}")

    only_if do
      File.directory?("#{deploy[:deploy_to]}/current")
    end
  end
end
