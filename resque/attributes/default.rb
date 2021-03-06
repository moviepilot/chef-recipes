default[:resque] = {}
default[:resque][:version] = '1.9.7'
default[:resque][:max_memory] = 300
default[:resque][:web] = {}
default[:resque][:web][:enabled] = true
default[:resque][:resque_config] = "/etc/rails/resque.yml"
default[:resque][:resque_worker_config] = "./current/config/resque_worker.yml"
default[:resque][:has_scheduler] = true