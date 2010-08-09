package "openjdk-6-dbg"
package "openjdk-6-jre"
package "openjdk-6-jdk"
package "openjdk-6-jre-lib"
package "openjdk-6-jre-headless"

user node[:sunspot_solr][:user] do
  gid 'users'
  home '/var/lib/solr'
  shell '/bin/sh'
  action :create
end

gem_package "sunspot" do
  action :install
  retries 2
end

[node[:sunspot_solr][:home], node[:sunspot_solr][:conf], node[:sunspot_solr][:log], node[:sunspot_solr][:pids]].each do |dir|
  directory dir do
    action :create
    owner node[:sunspot_solr][:user]
    group 'users'
    mode '0755'
  end
end

template "/etc/monit/conf.d/solr.monitrc" do
  source "sunspot.monit.erb"
  owner 'root'
  group 'root'
  mode '0644'
end

execute "monit reload && monit restart all -g solr" do
  action :run
end
