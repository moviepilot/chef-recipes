execute "echo 'appserver' > #{node[:role][:role_file]}" do
  cwd "/etc"
end

include_recipe 'role::install'
include_recipe 'scalper::install'
include_recipe 'ruby19::install'
include_recipe 'announcer::install'
include_recipe 'bundler::install'
include_recipe 'nginx-appserver::install'
include_recipe 'application::install'
include_recipe 'raisin::configure'
include_recipe 'mongodb::configure'
include_recipe 'sunspot-solr::client'
include_recipe 'application::configure'
include_recipe 'resque::configure'
include_recipe 'memcached-upstream::configure-client'

