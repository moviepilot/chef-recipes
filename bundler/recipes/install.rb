remote_file "/tmp/rubygems-#{node[:bundler][:gems_version]}.tgz" do
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{node[:bundler][:gems_version]}.tgz"
  not_if do
    File.exists?("/tmp/rubygems-#{node[:bundler][:gems_version]}.tgz")
  end
end

execute "tar xvfz rubygems-#{node[:bundler][:gems_version]}.tgz" do
  cwd "/tmp"
  umask 022
  not_if do
    File.exists?("/tmp/rubygems-#{node[:bundler][:gems_version]}")
  end
end

execute "Updating Rubygems to #{node[:bundler][:gems_version]}" do
  command "#{node[:bundler][:ruby_binary]} setup.rb"
  cwd "/tmp/rubygems-#{node[:bundler][:gems_version]}"
  umask 022
  not_if do
    File.exists?(node[:bundler][:gem_binary]) && `#{node[:bundler][:gem_binary]} -v`.strip == node[:bundler][:gems_version]
  end
end



gem_package 'bundler' do
  version node[:bundler][:version]
  gem_binary "#{node[:bundler][:gem_binary]}"
  retries 2
end





