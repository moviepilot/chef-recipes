include_recipe "raisin::user"
include_recipe "raisin::directory"

execute "yes sun: we fully agree" do
	command "echo 'sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true' | debconf-set-selections"
end

execute "aggreeing to java licencse" do
	command "echo 'sun-java6-jdk shared/accepted-sun-dlj-v1-1 boolean true' | debconf-set-selections"
end

package "sun-java6-jdk"
package "maven2"

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
