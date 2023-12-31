# bash script to process the expressjs-api-dc-template and deploy it to a dev namespace

#!/bin/bash

objects=( $DC_TEMPLATE $SERVICE_TEMPLATE $ROUTE_TEMPLATE )

for i in "${objects[@]}"
do
    oc process -f /home/runner/work/testing/testing/openshift/templates/$DIR/"$i" --namespace=femmyreuben-dev \
        -p APPLICATION_NAME=$APPLICATION_NAME \
        -p IMAGESTREAM=$IMAGESTREAM \
        -p ENVIRONMENT=$ENVIRONMENT | \
        oc apply -f -
done
