# Cost optimization authN

## Overview

Schedule non-production instances to shutdown on schedule, Cost Optimization Framework (COF) will allow you to schedule the instance shutdown and startup time. COF also provide ability to re-size instances based on their current utilization pattern.

### Pre-requiistes

## 2. Authentication configuration

Development authentication is performed via a local YAML configuration file. Stored at default location ~/.cof/csp_auth.yaml or .cof/csp_auth.yaml, however, authentication file path can be supplied at the runtime as script parameter to csp-authentication.sh script.

Authentication YAML format:
```


auth_config:
  aws:
    access_key: xxxxxxxxxxxxxxxxxxxxxxxxx
    secret_access_key: xxxxxxxxxxxxxxxxxx
    region: xxxxxxxxxxxxxxxxxxxxxxxxx
    output: xxxxxxxxxxxxxxxxxxxxxxxxx
  #azure:
   # client_id:xxxxxxxxxxxxxxxxxxxxx
    #client_secret:xxxxxxxxxxxxxxxxxxxx
    #subscription_id:xxxxxxxxxxxxxxxxxx
    #tenant_id:xxxxxxxxxxxxxxxxxxx

```
    NOTE: You should have AWS and Azure account with appropriate permissions.