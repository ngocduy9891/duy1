# deploy.sh
#! /bin/bash

SHA1=$1

# Push image to ECR
login="$(aws ecr get-login --region ap-southeast-1)"
${login}
docker tag app 012881927014.dkr.ecr.ap-southeast-1.amazonaws.com/docker:$SHA1         
docker push 012881927014.dkr.ecr.ap-southeast-1.amazonaws.com/docker:$SHA1

# Create new Elastic Beanstalk version
aws elasticbeanstalk create-application-version --application-name ngocduy --auto-create-application \
    --version-label $SHA1 \
    --region ap-southeast-1
