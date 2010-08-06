include_recipe "application::checkout"

node[:deploy].each do |application, deploy|
  #execute "create symbolic link to resque config" do
  #  command "ln -sf #{node[:resque][:resque_config]} #{deploy[:resque_config]}"
  #end
end
