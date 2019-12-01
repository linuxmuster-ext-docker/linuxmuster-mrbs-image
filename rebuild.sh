#!/bin/bash

git status
php_version=$(cat php_version.txt)
grep $php_version Dockerfile || { echo "$php_version not in Dockerfile, please fix"; exit 1 ; }
git commit -a -m"linuxmuster/mrbs: php version: $php_version" 

docker pull php:apache
docker inspect php:apache | grep RepoTags -A 3
git_log=$(git log --oneline | head -1 | cut -d " " -f 1)
echo "Press enter to build with: docker build -t linuxmuster/mrbs:$php_version-$git_log ."
read
docker build -t linuxmuster/mrbs:$php_version-$git_log .
docker tag linuxmuxster/mrbs:$php_version-$git_log linuxmuster/mrbs:latest
echo "Try if :latest works for you. Then press enter to tag and upload using"
echo "docker tag linuxmuster/mrbs:$php_version-$git_log linuxmuster/mrbs:working"
echo "docker push linuxmuster/mrbs:$php_version-$git_log ; docker push linuxmuster/mrbs:latest"
read
docker tag linuxmuster/mrbs:$php_version-$git_log linuxmuster/mrbs:working
docker push linuxmuster/mrbs:$php_version-$git_log ; docker push linuxmuster/mrbs:latest

