include_recipe "deploy::user"
include_recipe "deploy::directory"

# No need to check out the source when we're on a Rails
# App Server.
#unless node[:scalarium][:instance][:roles].include?('rails-app')
#  node[:deploy].each do |application, deploy|
#    %w(log config system pids).each do |dir_name|
#      directory "#{deploy[:deploy_to]}/shared/#{dir_name}" do
#        group deploy[:group]
#        owner deploy[:user]
#        mode "0770"
#        action :create
#        recursive true  
#      end
#    end
#
#    directory "#{deploy[:deploy_to]}/shared/cached-copy" do
#      recursive true
#      action :delete
#    end
#
#    deploy deploy[:deploy_to] do
#      repository deploy[:scm][:repository]
#      user deploy[:user]
#      revision deploy[:scm][:revision]
#      migrate false
#      environment "RAILS_ENV" => deploy[:rails_env], "RUBYOPT" => ""
#      symlink_before_migrate({})
#      restart_command "echo"
#      action deploy[:action]
#      case deploy[:scm][:scm_type].to_s
#      when 'git'
#        scm_provider Chef::Provider::Git
#        enable_submodules deploy[:enable_submodules]
#        shallow_clone true
#      when 'svn'
#        scm_provider Chef::Provider::Subversion
#        svn_username deploy[:scm][:user]
#        svn_password deploy[:scm][:password]
#      else
#        raise "unsupported SCM type #{deploy[:scm][:scm_type].inspect}"
#      end
#      before_migrate lambda{}
#      after_restart lambda{}
#      before_symlink lambda{}
#      before_restart lambda{}
#    end
#
#    template "#{deploy[:deploy_to]}/current/config/database.yml" do
#      source "database.yml.erb"
#      mode "0660"
#      group deploy[:group]
#      owner deploy[:user]
#      variables(:database => deploy[:database], :environment => deploy[:rails_env])
#      cookbook "rails" 
#    end
#
#    execute "fix access rights on deployment directory" do
#      command "chmod o-w #{deploy[:deploy_to]}"
#      action :run
#    end
#  end
#end


node[:deploy].each do |application, deploy|
  directory "/var/log/varnish" do
    action :create
    owner deploy[:user]
    group deploy[:group]
    mode "0755"
  end

  directory "/var/run/varnish" do
    action :create
    owner deploy[:user]
    group deploy[:group]
    mode "0755"
  end
end
