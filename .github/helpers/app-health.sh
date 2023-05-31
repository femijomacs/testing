# bash script to watch deployment of dc in dev namespace to ensure it is healthy and live

#!/bin/bash

oc rollout status -n dev dc/$APPLICATION_NAME --watch
