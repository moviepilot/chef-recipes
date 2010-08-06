include_recipe "application::checkout"

node[:deploy].each do |application, deploy|
  execute "gem install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc" do
	  command "gem install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc"
  end
  execute "bundle" do
    cwd deploy[:release_path]
    command "cd #{deploy[:current_path]} && bundle install --without test:development"
  end

  execute "create symbolic link to discovery config" do
    command "ln -sf #{node[:sunspot_solr][:discovery_config]} #{deploy[:current_path]}/config/discovery.yml"
  end
end
