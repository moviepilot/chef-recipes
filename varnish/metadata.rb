maintainer        "Moviepilot Gmbh"
maintainer_email  "hosting@moviepilot.com"
license           "Apache 2.0"
description       "Installs and configures Varnish"
long_description  "Will set install Varnish server and set it up"
version           "0.1"
recipe            "varnish::install", "Installs packages required for Sphinx servers"
recipe            "varnish::deploy", "Deploys Varnish Configuration"

supports 'ubuntu'
