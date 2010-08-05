execute "url http://github.com/moviepilot/scalper/raw/master/scalper-installer > /tmp/scalper-installer" do
    command "curl http://github.com/moviepilot/scalper/raw/master/scalper-installer > /tmp/scalper-installer"
    action :run
end

execute "sh /tmp/scalper-installer" do
    command "sh /tmp/scalper-installer"
    action :run
end

