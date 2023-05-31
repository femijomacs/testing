# bash script to process the expressjs-api-dc-template and deploy it to a given namespace

#!/bin/bash

objects=( $DC_TEMPLATE $SERVICE_TEMPLATE $ROUTE_TEMPLATE )

for i in "${objects[@]}"
do
    oc process -f /home/runner/work/femi-olaniran-IS27-devops-specialist-competition-req99120/femi-olaniran-IS27-devops-specialist-competition-req99120/openshift/templates/$DIR/"$i" --namespace=dev \
        -p APPLICATION_NAME=expressjs-api \
        -p IMAGESTREAM=expressjs-api \
        -p ENVIRONMENT=dev | \
        oc apply -f -
done
