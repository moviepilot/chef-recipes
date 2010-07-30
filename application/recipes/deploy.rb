node[:deploy].each do |application, deploy|
  Dir "#{deploy[:release_path]}/vendor/gems/*.gem"].each do |gem_file|
    execute "install gem #{gem_file}" do
      command "gem install #{gem_file} --no-ri --no-rdoc -q"
    end
  end
  execute "bundle" do
    cwd deploy[:release_path]
    command "bundle install --without test:development"
  end
end
