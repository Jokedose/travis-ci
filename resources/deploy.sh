#!/bin/bash

set-e

dockerbuild-tasia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMIT.
dockertagasia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMITasia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:latest

gcloudauthactivate-service-account--key-file$HOME/google-cloud-sdk/gcloud-service-key.json

gcloud--quietconfigsetproject${PROJECT_NAME}
gcloud--quietconfigsetcontainer/cluster${CLUSTER_NAME}
gcloud--quietconfigsetcompute/zone${CLOUDSDK_COMPUTE_ZONE}
gcloud--quietcontainerclustersget-credentials${CLUSTER_NAME}

gclouddocker--pushasia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}

yes|gcloudbetacontainerimagesadd-tagasia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMITasia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:latest

kubectlconfigview
kubectlconfigcurrent-context

kubectlsetimagedeployment/${PROJECT_IMAGES}${PROJECT_IMAGES}=asia.gcr.io/${PROJECT_NAME}/${PROJECT_IMAGES}:$TRAVIS_COMMIT