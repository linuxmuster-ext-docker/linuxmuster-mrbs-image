#!/bin/bash

git status
php_version=$(cat php_version.txt)
git commit -a -m"linuxmuster-mrbs: php version: $php_version" 

docker pull php:apache
docker inspect php:apache | grep RepoTags -A 3
git_log=$(git log --oneline | head -1 | cut -d " " -f 1)
echo "Press enter to build with: docker build -t hgkvplan/linuxmuster-mrbs:$php_version-$git_log ."
read
docker build -t hgkvplan/linuxmuster-mrbs:$php_version-$git_log .
docker tag hgkvplan/linuxmuster-mrbs:$php_version-$git_log hgkvplan/linuxmuster-mrbs:latest
echo "Try if :latest works for you. Then upload using"
echo "docker push hgkvplan/linuxmuster-mrbs:$php_version-$git_log ; docker push hgkvplan/linuxmuster-mrbs:latest"
