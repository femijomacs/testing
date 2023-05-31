# bash script to watch deployment of dc in a given namespace to ensure it is healthy and live

#!/bin/bash

oc rollout status -n $NAMESPACE dc/$APPLICATION_NAME --watch
