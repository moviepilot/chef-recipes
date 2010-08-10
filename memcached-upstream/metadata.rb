maintainer        "Moviepilot Gmbh"
maintainer_email  "hosting@moviepilot.com"
license           "Apache 2.0"
description       "Installs and configures Memcached"
long_description  "Will set install MemcacheD server from upstream and set it up"
version           "0.1"
recipe            "memcached_upstream::install", "Installs packages required rs"
recipe            "memcached_upstream::deploy", "Deploys Varnish Configuration"

supports 'ubuntu'
