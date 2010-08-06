default[:deploy] = {}

application = "moviepilot_i18n"

default[:deploy][application] = Mash.new
deploy = default[:deploy][application]

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
