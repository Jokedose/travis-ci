#codito-jan2017

PresentationrepositoryatCoditoErgoSumhostedbyTheFamilyinParis,Jan19th2017.Edit

###Demo

-CreateaK8Scluster
-Gettheclustercredentials
-CreateaPrivateGitHubrepocontainingyourapplicationcode,etc.
-CreateandaddtheDockerfile
-BuildandtesttheDockerimage
-PushtheDockerimageinGCR:`gclouddocker--pushasia.gcr.io/travis-ci-280602/jokedose-travisci:pre`
-CreatetheK8Sdeploymentandallowexternaltraffictotheapplication

(Atthispointyouhavetheapplication/containerrunninginthecluster!!!)

-EnablethecreatedrepoonTravis
-Createandaddthe.travis.ymlanddeploy.shfile
-Run`chmod+xresources/deploy.sh`togiveexecutionpermissiontothedeploy.shfile
-CreateanddownloadagcloudkeyinJSONformat
-Run`catgcloud.json|base64`andcopytheoutput
-Createasecret`GCLOUD_SERVICE_KEY`variableintheTravisreposettings
-Committheeverything

###Buildandtestthecontainer

```
dockerbuild-tasia.gcr.io/travis-ci-280602/jokedose-travisci:pre.
dockerrun-d-p8080:8080--namejokedose-travisciasia.gcr.io/travis-ci-280602/jokedose-travisci:pre
```

###Getclustercredentials

```
gcloud--quietconfigsetprojecttravis-ci-280602
gcloud--quietconfigsetcontainer/clustercluster-jokedose-travisci
gcloud--quietconfigsetcompute/zoneasia-southeast1-a
gcloud--quietcontainerclustersget-credentialscluster-jokedose-travisci
```

###Createthedeployment

```
kubectlcreatedeploymentjokedose-travisci--image=asia.gcr.io/travis-ci-280602/jokedose-travisci:pre
kubectlexposedeploymentjokedose-travisci--type="LoadBalancer"--port=8080
```

###Connecttothecluster

```
gcloudcontainerclustersget-credentialscluster-jokedose-travisci--zoneasia-southeast1-a--projecttravis-ci-280602
kubectlproxy
```

###Scaleuptheapplication(optional)

```
kubectlscaledeploymentjokedose-travisci--replicas=3
```
