maintainer        "Moviepilot Gmbh"
maintainer_email  "hosting@moviepilot.com"
license           "Apache 2.0"
description       "Installs and configures MongoDb"
long_description  "Will set install MongoDbserver and set it up"
version           "0.1"
recipe            "mongodb::install", "Installs packages required for MongoDb servers"
recipe            "mongodb::deploy", "Deploys Varnish Configuration"

supports 'ubuntu'
