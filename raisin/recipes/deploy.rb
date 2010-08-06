include_recipe "raisin::checkout"

node[:deploy].each do |application, deploy|
  #execute "create symbolic link to resque config" do
  #  command "ln -sf #{node[:resque][:resque_config]} #{deploy[:resque_config]}"
  #end
  #
  next if deploy[:application] != "raisin"

  execute "build raisin" do
    cwd deploy[:current_path]
    command "./script/build.sh #{deploy[:current_path]}"
  end

  execute "create pid dir" do
    command "mkdir -p #{deploy[:current_path]}/pids"
  end

  execute "stop raisin if it's running" do
    cwd deploy[:current_path]
    command "./script/stop_raisin_manager.sh #{deploy[:current_path]} 80"
  end

  execute "start raisin" do
    cwd deploy[:current_path]
    command "./script/start_raisin_manager.sh #{deploy[:current_path]} 80"
  end
end
