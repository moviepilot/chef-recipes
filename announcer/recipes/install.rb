gem_package "xmpp4r" do
  action :install
  retries 2
end

[:"xmpp_user", :"xmpp_password", :"xmpp_chat_room"].each do |variable|
  raise "please set node[:config][:announcer][:#{variable}] in order to user announcer" unless node[:config][:announcer][variable]
end

template "/usr/bin/announce" do
  source "announce.rb.erb"
  owner 'root'
  group 'root'
  mode '0755'

  variables :user   => node[:config][:announcer][:"xmpp_user"],
            :passwd => node[:config][:announcer][:"xmpp_password"],
            :room   => node[:config][:announcer][:"xmpp_chat_room"]

end
