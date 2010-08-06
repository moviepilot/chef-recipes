include_recipe "raisin::user"
include_recipe "raisin::directory"

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

include_recipe "raisin::deploy"
