execute "wget --no-check-certificate https://github.com/moviepilot/scalper/raw/master/scalper-installer -O /tmp/scalper-installer" do
    command "wget --no-check-certificate https://github.com/moviepilot/scalper/raw/master/scalper-installer -O /tmp/scalper-installer"
    action :run
end

execute "sh /tmp/scalper-installer" do
    command "sh /tmp/scalper-installer"
    action :run
end

