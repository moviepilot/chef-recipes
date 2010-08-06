include_recipe "application::checkout"

node[:deploy].each do |application, deploy|
  next if deploy[:application_type]  != 'rails'

  execute "gem install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc" do
	  command "gem install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc"
  end
  execute "bundle" do
    cwd deploy[:release_path]
    command "cd #{deploy[:current_path]} && bundle install --without test:development"
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
end
