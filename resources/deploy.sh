#!/bin/bash

set -e

docker build -t asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMIT .
docker tag asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMIT asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:latest

echo ${GCLOUD_SERVICE_KEY_TEST} | base64 --decode -i
echo ${GCLOUD_SERVICE_KEY_TEST} | base64 --decode -i > /home/travis/gcloud-service-key.json
gcloud auth activate-service-account --key-file /home/travis/gcloud-service-key.json

gcloud --quiet config set project ${PROJECT_NAME}
gcloud --quiet config set container/cluster ${CLUSTER_NAME}
gcloud --quiet config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud --quiet container clusters get-credentials ${CLUSTER_NAME}

gcloud docker -- push asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}

yes | gcloud beta container images add-tag asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMIT asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:latest

kubectl config view
kubectl config current-context

kubectl set image deployment/${PROJECT_IMAGES} ${PROJECT_IMAGES}=asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMIT