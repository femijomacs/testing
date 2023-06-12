# bash script to watch deployment of dc in dev namespace to ensure it is healthy and live

#!/bin/bash

oc rollout status -n femmyreuben-dev dc/$APPLICATION_NAME --watch
curl -s -I "$(oc get route -n femmyreuben-dev expressjs-api -o jsonpath='{.spec.host}')/api/health"
