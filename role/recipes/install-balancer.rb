include_recipe 'role::install'
include_recipe 'nginx-balancer::install'
include_recipe 'varnish::install'
include_recipe 'pen::install'

execute "echo 'balancer' > #{node[:role][:role_file]}" do
  cwd "/etc"
end

