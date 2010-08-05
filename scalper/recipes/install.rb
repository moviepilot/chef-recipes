execute "bash < <(curl http://github.com/moviepilot/scalper/raw/master/scalper-installer)" do
  command "curl http://github.com/moviepilot/scalper/raw/master/scalper-installer > /tmp/scalper-installer"
  command "sh /tmp/scalper-installer"
  action :run
end

