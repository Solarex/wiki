#!/bin/bash
echo $PWD
git branch -a
git checkout md
rsync -rvt /home/hrh/Workspace/Solarex/Wiki/content .
