execute "gem update --system" do
  command "gem update --system"
  action :run
end

gem_package 'bundler' do
  version node[:bundler][:version]
  gem_binary "#{node[:bundler][:gem_binary]}"
  retries 2
end
