maintainer        "Peritor GmbH"
maintainer_email  "scalarium@peritor.com"
license           "Apache 2.0"
description       "Installs, deploys and configures Resque for client or server"
version           "0.1"
recipe            "resque::install", "Installs Resque on the worker machine"
recipe            "resque::deploy", "Deploys and restarts Resque workers"
recipe            "resque::configure", "Re-configure Rails applications to use the correct Redis server"

supports 'ubuntu'

