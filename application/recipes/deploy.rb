include_recipe "application::checkout"

node[:deploy].each do |application, deploy|
  #Dir["#{deploy[:current_path]}/vendor/gems/*.gem"].each do |gem_file|
  #  # :TODO: Add a check if the gem is already installed
  #  execute "install gem #{gem_file}" do
  #    command "gem install #{gem_file} --no-ri --no-rdoc -q"
  #  end
  #end
  execute "gem install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc" do
	  command "gem install #{deploy[:current_path]}/vendor/gems/*.gem --no-ri --no-rdoc"
  end
  execute "bundle" do
    cwd deploy[:release_path]
    command "cd #{deploy[:current_path]} && bundle install --without test:development"
  end
end
