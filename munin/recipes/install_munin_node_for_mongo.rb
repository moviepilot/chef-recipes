include_recipe "munin::install_munin_node"

gem_package "mongo" do
  version  "1.0.9" 
  retries 2
end

