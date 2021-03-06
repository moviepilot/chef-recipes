include_recipe "deploy" # get the deployment attributes

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    next
  end
  
  template "#{node[:nginx_appserver][:vhost_dir]}/site-moviepilot" do
    variables  :document_root => deploy[:mp_document_root]
    source "site-moviepilot.nginx.erb"
    owner  node[:nginx_appserver][:user]
    mode   0644
  end

end
