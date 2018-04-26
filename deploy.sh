# deploy.sh
#! /bin/bash

SHA1=$1

# Push image to ECR
login="$(aws ecr get-login --region ap-southeast-1)"
${login}
docker tag app 012881927014.dkr.ecr.ap-southeast-1.amazonaws.com/docker:$SHA1         
docker push 012881927014.dkr.ecr.ap-southeast-1.amazonaws.com/docker:$SHA1

# Create new Elastic Beanstalk version
EB_BUCKET=ngocduy-deploy-bucket
DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json
sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json > $DOCKERRUN_FILE
aws elasticbeanstalk create-application-version --application-name ngocduy \
    --version-label $SHA1 \
    --region ap-southeast-1

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name ngocduy-env \
    --version-label $SHA1 \
    --region ap-southeast-1
