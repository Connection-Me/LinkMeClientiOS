#!/bin/bash

line=' ========= '
if [ -z "$1" ]; then
    echo "$line"" Commit message is empty. Can  not be comitted ""$line"
    exit 1
fi

echo ""
echo $line' add files (*.xcscheme *.h *.m *.mm *.xib *.strings *.plist *.png *.jpg *.txt *.sh *.pbxproj *.proto *.zip)  '$line
git add *.txt *.json *.pb *.pch *.c *.pb *.xcscheme *.proto *.h *.m *.mm *.xib *.strings *.plist *.png *.jpg *.txt *.sh *.pbxproj *.zip .gitignore
echo ''

echo $line' auto checkout unuse files (*xcbkptlist *xcuserstate *DS_Store)  '$line
git checkout *xcbkptlist 
git checkout *xcuserstate 
git checkout *DS_Store
echo ''

echo $line' oh, commit files. comment: '"$1"" "$line
git commit -m "$1"
echo ''

if [ x$2 = x ]
    then
        echo $line' hey, pull code from server '$line
        git pull origin master
        echo ''
    else
        echo $line' Skip pull from server '$line
fi



echo $line' wow, push code to server '$line
git push

echo ''
echo $line' congratulations! hope there is no conflict! '$line
echo ''


