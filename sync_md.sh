#!/bin/bash
echo $PWD
simiki=/Users/houruhou/Workspace/OpenSource/Blog+Wiki/simiki
git branch -a
git checkout md
rm -rf content/*
rsync -rvt ${simiki}/content .
