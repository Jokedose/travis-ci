#!/bin/bash

set -e

docker build -t asia.gcr.io/${PROJECT_NAME}/jokedose-travisci:$TRAVIS_COMMIT .
docker tag asia.gcr.io/${PROJECT_NAME}/jokedose-travisci:$TRAVIS_COMMIT asia.gcr.io/${PROJECT_NAME}/jokedose-travisci:latest

echo $GCLOUD_SERVICE_KEY | base64 --decode -i > ${HOME}/travis-ci-280602-225bf98f45dc.json
gcloud auth activate-service-account --key-file ${HOME}/travis-ci-280602-225bf98f45dc.json

gcloud --quiet config set project $PROJECT_NAME
gcloud --quiet config set container/cluster $CLUSTER_NAME
gcloud --quiet config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud --quiet container clusters get-credentials $CLUSTER_NAME

gcloud docker push asia.gcr.io/${PROJECT_NAME}/jokedose-travisci

yes | gcloud beta container images add-tag asia.gcr.io/${PROJECT_NAME}/jokedose-travisci:latest

kubectl config view
kubectl config current-context

kubectl set image deployment/jokedose-travisci jokedose-travisci=asia.gcr.io/${PROJECT_NAME}/jokedose-travisci:$TRAVIS_COMMIT
