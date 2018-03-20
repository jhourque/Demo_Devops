#!/bin/bash

cd ../terraform/static
repo=$(terraform output ecr_app_url)
echo $repo
cd -

cp -f src/index.php.v1 src/index.php
docker build -t simple-php-app:1.0 .
cp -f src/index.php.v2 src/index.php
docker build -t simple-php-app:2.0 .

docker tag simple-php-app:1.0 $repo:1.0
docker tag simple-php-app:2.0 $repo:2.0
docker tag simple-php-app:1.0 $repo:latest

$(aws ecr get-login)

docker push $repo:1.0
docker push $repo:2.0
docker push $repo:latest


