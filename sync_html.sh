#!/bin/bash
echo $PWD
simiki=/Users/Solarex/Workspace/Solarex/simiki
git branch -a 
git checkout gh-pages
rsync -rvt ${simiki}/output/* .
echo "sync successed"
read -p "Press any key to continue......" key
for html in `find . -maxdepth 2 -type f -name "*.html" | grep -v 'index'`
do
    echo $html
    sed -i "s@/static/css/@../static/css/@g" $html
done
sed -i "s@/static/css/@./static/css/@g" index.html
