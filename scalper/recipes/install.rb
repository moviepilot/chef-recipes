execute "url https://github.com/moviepilot/scalper/raw/master/scalper-installer > /tmp/scalper-installer" do
    command "curl https://github.com/moviepilot/scalper/raw/master/scalper-installer > /tmp/scalper-installer"
    action :run
end

execute "sh /tmp/scalper-installer" do
    command "sh /tmp/scalper-installer"
    action :run
end

