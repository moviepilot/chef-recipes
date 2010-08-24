gem_package "xmpp4r" do
  action :install
  retries 2
end

[:"xmpp-user", :"xmpp-password", :"xmpp-chat-room"] do |variable|
  raise "please set node[:config][:announcer][:#{variable}] in order to user announcer" unless node[:config][:announcer][variable]
end

template "/bin/announce" do
  source "announce.rb.erb"
  owner 'root'
  group 'root'
  mode '0755'

  variables :user   => node[:config][:announcer][:"xmpp-user"],
            :passwd => node[:config][:announcer][:"xmpp-password"],
            :room   => node[:config][:announcer][:"xmpp-chat-room"]

end
