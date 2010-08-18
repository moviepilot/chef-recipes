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
    command "./script/stop_raisin_manager.sh #{deploy[:current_path]} #{node[:raisin][:port]}"
  end

  execute "start raisin" do
    cwd deploy[:current_path]
    command "./script/start_raisin_manager.sh #{deploy[:current_path]} #{node[:raisin][:port]}"
  end


  next unless node[:config][:setup_raisin]

  raise "\n\n\n\n\n\n*************************************************************************************\n'setup_raisin' is set but could not find a ratings dump at #{node[:raisin][:fill_raisin][:dump_file]}\n*************************************************************************************\n\n\n\n\n\n" unless File.exists?( node[:raisin][:fill_raisin][:dump_file] )

  template node[:raisin][:fill_raisin][:script] do
    source "fill_raisin.sh.erb"
    mode    0755

    variables :log_file => node[:raisin][:fill_raisin][:log_file],
              :dump_file => node[:raisin][:fill_raisin][:dump_file],
              :port => node[:raisin][:port]


  end
  execute "fill raisin" do
    command "screen -d -m #{node[:raisin][:fill_raisin][:script]}"
  end

end
