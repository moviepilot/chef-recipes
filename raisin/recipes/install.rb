mem_in_gb=`free -m -g |  grep Mem | sed 's/ [ ]*/ /g' | cut -f2 -d" "`.to_i

raise "\n\n\n\n\n\n*************************************************************************************\nRaisin needs at least 5 Gigs of RAM!!!!\n*************************************************************************************\n\n\n\n\n\n" unless mem_in_gb >= 5

include_recipe "raisin::user"
include_recipe "raisin::directory"

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


package "maven2"
package "htop"

node[:deploy].each do |application, deploy|
  # create shared/ directory structure
  %w(log config system pids).each do |dir_name|
    directory "#{deploy[:deploy_to]}/shared/#{dir_name}" do
      group deploy[:group]
      owner deploy[:user]
      mode "0770"
      action :create
      recursive true
    end
  end
end

include_recipe "raisin::deploy"
