default[:deploy] = {}
default[:app_identifier] = "app"

deploy.each do |application, deploy|
  default[:deploy][application] = Mash.new
  default[:deploy][application][:scm] = {}
  default[:deploy][application][:scm][:scm_type]  = "git"
  default[:deploy][application][:scm][:revision]  = "HEAD"
  default[:deploy][application][:deploy_to]       = "/srv/www/#{application}"
  default[:deploy][application][:release]         = Time.now.utc.strftime("%Y%m%d%H%M%S")
  default[:deploy][application][:release_path]    = "#{deploy[:deploy_to]}/releases/#{deploy[:release]}"
  default[:deploy][application][:current_path]    = "#{deploy[:deploy_to]}/current"
  default[:deploy][application][:mp_document_root]   = "#{deploy[:deploy_to]}/current/public"
  default[:deploy][application][:rails_env]       = 'production'
  default[:deploy][application][:sleep_before_restart] = 0
  default[:deploy][application][:config_dir]      = "#{deploy[:current_path]}/config"
  default[:deploy][application][:mongodb_config]  = "#{deploy[:config_dir]}/discovery.yml"
  default[:deploy][application][:discovery_config]  = "#{deploy[:config_dir]}/database.mongo.yml"
  default[:deploy][application][:resque_config]  = "#{deploy[:config_dir]}/resque.yml"
  default[:deploy][application][:raisin_config]  = "#{deploy[:config_dir]}/raisin.yml"
  default[:deploy][application][:memcached_upstream_config]  = "#{deploy[:config_dir]}/memcached_upstream.yml"
  default[:deploy][application][:gem_binary] = '/opt/ruby/bin/gem'
  default[:deploy][application][:bundle_binary] = '/opt/ruby/bin/bundle'
end
