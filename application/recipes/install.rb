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
  command "echo \"\n\" >> /etc/environment"
end

execute "set environment vars" do
  command "echo 'RAILS_ENV=production' >> /etc/environment"
end

include_recipe "application::deploy"

MY_IP=`curl -s http://whatismyip.org/`.strip

execute "announce that I am up and running" do
  command "announce 'hey hoh ... I am a rails app server and I am up and running at http://#{MY_IP}' || true"
end
