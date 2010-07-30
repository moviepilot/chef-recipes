maintainer        "Moviepilot GmbH"
maintainer_email  "hosting@moviepilot.com"
license           "Apache 2.0"
description       "Installs and configures nginx"
version           "0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end
