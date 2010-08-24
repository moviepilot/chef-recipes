node["scalarium"]["roles"][ node[:app_identifier] ]["instances"].each_with_index do |instance, index|
  internal_ip = [*instance].flatten[1]["private_ip"]  # this works in ruby 1.8.7 & 1.9.x (1.8.7 does Array-of-Hashes -> Array-of-Arrays on each)

  execute "configure balancer" do
    command "penctl localhost:8081 server #{index} address #{internal_ip} port 80"
  end
end

