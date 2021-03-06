node[:deploy].each do |application, deploy|
  unless application.match(/raisin/)
    Chef::Log.info("raisin::checkout skipping non-raisin app: #{application}")
    next
  else
    Chef::Log.info("raisin::checkout checking out #{application}")
  end
  
  ensure_scm_package_installed(deploy[:scm][:scm_type])
  
  prepare_git_checkouts(:user => deploy[:user], 
                        :group => deploy[:group], 
                        :home => deploy[:home], 
                        :ssh_key => deploy[:scm][:ssh_key]) if deploy[:scm][:scm_type].to_s == 'git'

  directory "#{deploy[:deploy_to]}/shared/cached-copy" do
    recursive true
    action :delete
  end
  
  # setup deployment & checkout
  deploy deploy[:deploy_to] do
    repository deploy[:scm][:repository]
    user deploy[:user]
    revision deploy[:scm][:revision]
    symlink_before_migrate deploy[:symlink_before_migrate]
    action deploy[:action]
    restart_command "sleep #{deploy[:sleep_before_restart]} && #{deploy[:restart_command]}"
    scm_provider Chef::Provider::Git
    # enable_submodules true
    shallow_clone true
  end
end
