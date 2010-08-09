execute "yes sun: we fully agree" do
	command "echo 'sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true' | debconf-set-selections"
end

execute "aggreeing to java licencse" do
	command "echo 'sun-java6-jdk shared/accepted-sun-dlj-v1-1 boolean true' | debconf-set-selections"
end

execute "setting sun java as default java home in /etc/environment" do
	command "echo 'JAVA_HOME=/usr/lib/jvm/java-6-sun/' >> /etc/environment"
end

package "sun-java6-jdk"

execute "setting sun java as default via update-alternatives" do
	command "update-alternatives --set java /usr/lib/jvm/java-6-sun/jre/bin/java"
end

execute "setting sun javac as default via update-alternatives" do
	command "update-alternatives --set javac /usr/lib/jvm/java-6-sun/bin/javac"
end


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
