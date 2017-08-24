#!/usr/local/bin/bash

cd public

git add .
msg="Release: "$(date)
git ci -m "$msg"
git push origin master

cd ..
echo
echo "$msg Done!!"

