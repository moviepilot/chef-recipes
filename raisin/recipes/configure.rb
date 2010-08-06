include_recipe "deploy" # get the deployment attributes

node[:deploy].each do |application, deploy|
end
