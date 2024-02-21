#!/bin/bash

set -x


REPO_URL="https://github.com/colossus06/microservices-release"
git clone "$REPO_URL" /tmp/temp_repo
cd /tmp/temp_repo
#$2=$(Build.BuildId)
#$1=$(service)
#$(Build.BuildId) $(service)
sed -i "s/elkakimmie\/$1:latest/elkakimmie\/$1:$2/g" kubernetes-manifests.yaml

git add .
git commit -m "Update Kubernetes manifest"
git push
rm -rf /tmp/temp_repo