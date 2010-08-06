default[:sunspot_solr] = {}
default[:sunspot_solr][:port] = 8983
default[:sunspot_solr][:user] = 'solr'
default[:sunspot_solr][:home] = '/var/lib/solr'
default[:sunspot_solr][:conf] = "/var/lib/solr/conf"
default[:sunspot_solr][:log] = "/var/lib/solr/log"
default[:sunspot_solr][:log_level] = "WARNING"
default[:sunspot_solr][:pids] = '/var/run/solr'
default[:sunspot_solr][:min_memory] = '256M'
default[:sunspot_solr][:max_memory] = '1024M'
default[:sunspot_solr][:monit_mem_limit] = '1024'
default[:sunspot_solr][:discovery_config] = "/etc/rails/discovery.yml"
