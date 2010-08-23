include_recipe "application::user"
include_recipe "application::directory"

node[:deploy].each do |application, deploy|
  # create shared/ directory structure
  %w(log config system pids).each do |dir_name|
    directory "#{deploy[:deploy_to]}/shared/#{dir_name}" do
      group deploy[:group]
      owner deploy[:user]
      mode "0770"
      action :create
      recursive true
    end
  end
end

execute "add newline" do
  command "echo "\n" >> /etc/environment"
end

execute "set environment vars" do
  command "echo "\n" >> /etc/environment"
  command "echo 'RAILS_ENV=production' >> /etc/environment"
end

include_recipe "application::deploy"
