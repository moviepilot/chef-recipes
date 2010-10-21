include_recipe "application::checkout"

node[:deploy].each do |application, deploy|
  next if deploy[:application_type]  != 'rails'

  execute "some log message" do
    command 'echo -e "just to let you know: #{deploy[:current_path]} expands to $(readlink -f #{deploy[:current_path]})"'
  end

  execute "#{deploy[:gem_binary]} install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc" do
	  command "#{deploy[:gem_binary]} install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc"
  end
  execute "bundle" do
    cwd deploy[:release_path]
    command "cd #{deploy[:current_path]} && #{deploy[:bundle_binary]} install --without test:development:github_ssh"
  end

  execute "create symbolic link to discovery config" do
    command "ln -sf #{node[:sunspot_solr][:discovery_config]} #{deploy[:mongodb_config]}"
  end

  execute "create symbolic link to mongodb config" do
    command "ln -sf #{node[:mongodb][:mongodb_config]} #{deploy[:discovery_config]}"
  end

  execute "create symbolic link to resque config" do
    command "ln -sf #{node[:resque][:resque_config]} #{deploy[:resque_config]}"
  end

  execute "create symbolic link to memcache config" do
    command "ln -sf #{node[:memcached_upstream][:memcached_upstream_config]} #{deploy[:memcached_upstream_config]}"
  end

  execute "create symbolic link to raisin config" do
    command "ln -sf #{node[:raisin][:config_file]} #{deploy[:raisin_config]}"
  end

  template "/etc/init.d/resque-web" do
    source "init-script.erb"
    owner  "root"
    group  "root"
    mode   "0755"

    variables :resque_config => deploy[:resque_initializer]
  end

#  execute "(re-)start resque-web" do
#    environment "HOME" => "/tmp"
#    command "/etc/init.d/resque-web restart"
#  end

  MY_IP=`curl -s http://whatismyip.org/`.strip

  execute "announce deployment" do 
    command "announce 'hey: moviepilot was deployed successfully at http://#{MY_IP} ... for accessing resque-web see http://#{MY_IP}/resque-web.txt ; ssh to it with ssh ubuntu@#{MY_IP} ; tunnel for resque: ssh -L8765:127.0.0.1:5678  -p 22 -N -t -x ubuntu@#{MY_IP}' || true"
  end
end
