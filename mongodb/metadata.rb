maintainer        "Moviepilot GmbH"
maintainer_email  "hosting@moviepilot.com"
license           "Apache 2.0"
description       "Installs and configures MongoDb"
long_description  "Will install MongoDB server (with monitrc)"
version           "0.1"
recipe            "mongodb::install", "Installs packages required for MongoDb servers"
recipe            "mongodb::deploy", "Deploys Varnish Configuration"
recipe            "mongodb::configure", "Maintain MongoDB database access information"

supports 'ubuntu'
