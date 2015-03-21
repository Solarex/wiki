#!/bin/bash
echo $PWD
simiki=/Users/Solarex/Workspace/Solarex/simiki
git branch -a
git checkout md
rsync -rvt ${simiki}/content .
