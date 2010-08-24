node["scalarium"]["roles"][ node[:app_identifier] ]["instances"].each do |instance|
  internal_ip = instance[ instance.keys.first ]["private_ip"]

  execute "configure balancer" do
    command "echo #{internal_ip} >> /tmp/foo"
  end
end
