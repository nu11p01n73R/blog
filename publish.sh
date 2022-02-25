#!/bin/zsh

cd public

git add .
msg="Release: "$(date)
git commit -m "$msg" && git push origin master

cd ..
echo
echo "$msg Done!!"

