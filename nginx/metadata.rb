maintainer        "Moviepilot GmbH"
maintainer_email  "hosting@peritor.com"
license           "Apache 2.0"
description       "Installs and configures Nginx"
long_description  "Will install Nginx web server from source"
version           "0.1"
recipe            "nginx::install", "Installs packages required for Nginx servers"
recipe            "nginx::deploy", "Deploys Nginx server configuration"

supports 'ubuntu'
