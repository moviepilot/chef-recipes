include_recipe "raisin::checkout"

node[:deploy].each do |application, deploy|
  #execute "create symbolic link to resque config" do
  #  command "ln -sf #{node[:resque][:resque_config]} #{deploy[:resque_config]}"
  #end
  #
  execute "build raisin" do
    cwd deploy[:current_path]
    command "./script/build.sh #{deploy[:current_path]}"
  end
end
