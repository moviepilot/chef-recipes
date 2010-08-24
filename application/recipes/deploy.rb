include_recipe "application::checkout"

node[:deploy].each do |application, deploy|
  next if deploy[:application_type]  != 'rails'

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

end
