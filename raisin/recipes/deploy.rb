include_recipe "raisin::checkout"

node[:deploy].each do |application, deploy|
  next if deploy[:application] != "raisin"

  execute "build raisin" do
    cwd deploy[:current_path]
    command "./script/build.sh #{deploy[:current_path]} || : "
  end

  execute "create pid dir" do
    command "mkdir -p #{deploy[:current_path]}/pids"
  end

  execute "stop raisin if it's running" do
    cwd deploy[:current_path]
    command "./script/stop_raisin_manager.sh #{deploy[:current_path]} #{default[:raisin][:port]}"
  end

  execute "start raisin" do
    cwd deploy[:current_path]
    command "./script/start_raisin_manager.sh #{deploy[:current_path]} #{default[:raisin][:port]}"
  end
end
