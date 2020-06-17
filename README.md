# Jokedose-travisci

### Demo

- Create a K8S cluster
- Get the cluster credentials
- Create a Private GitHub repo containing your application code, etc.
- Create and add the Dockerfile
- Build and test the Docker image
- Push the Docker image in GCR: `gcloud docker -- push asia.gcr.io/travis-ci-280602/jokedose-travisci:pre`
- Create the K8S deployment and allow external traffic to the application

(At this point you have the application/container running in the cluster!!!)

- Enable the created repo on Travis
- Create and add the .travis.yml and deploy.sh file
- Run `chmod +x resources/deploy.sh` to give execution permission to the deploy.sh file
- Create and download a gcloud key in JSON format
- Run `cat gcloud.json | base64` and copy the output
- Create a secret `GCLOUD_SERVICE_KEY` variable in the Travis repo settings
- Commit the everything

### Build and test the container

```
docker build -t asia.gcr.io/travis-ci-280602/jokedose-travisci:pre .
docker run -d -p 8080:8080 --name jokedose-travisci asia.gcr.io/travis-ci-280602/jokedose-travisci:pre
```

### Get cluster credentials

```
gcloud --quiet config set project travis-ci-280602
gcloud --quiet config set container/cluster cluster-jokedose-travisci
gcloud --quiet config set compute/zone asia-southeast1-a
gcloud --quiet container clusters get-credentials cluster-jokedose-travisci
```

### Create the deployment

```
kubectl create deployment jokedose-travisci --image=asia.gcr.io/travis-ci-280602/jokedose-travisci:pre
kubectl expose deployment jokedose-travisci --type="LoadBalancer" --port=8080
```

### Connect to the cluster

```
gcloud container clusters get-credentials cluster-jokedose-travisci --zone asia-southeast1-a --project travis-ci-280602
kubectl proxy
```

### Scale up the application (optional)

```
kubectl scale deployment jokedose-travisci --replicas=3
```
