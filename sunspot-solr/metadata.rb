maintainer        "Peritor GmbH"
maintainer_email  "scalarium@peritor.com"
license           "Apache 2.0"
description       "Installs and configures Solr using Sunspot"
long_description  "Builds on Sunspot (http://outoftime.github.com/sunspot/) to install, run and use Solr."
version           "0.1"
recipe            "sunspot-solr::client", "Transparently configures clients (i.e. Rails application servers) for use with Solr server"
recipe            "sunspot-solr::install", "Installs packages required for the Solr server"

supports 'ubuntu'
