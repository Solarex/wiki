---
title: "git"
date: 2014-06-11 23:28
---
## git config

```
[user]
	name = Solarex
	email = rh.hou.work@gmail.com
[core]
	editor = vim
[color]
	ui = auto
[alias]
	lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --
[commit]
    template = ~/.git_commit.template
```

## git flow

```
远程创建一个主分支，本地每人创建功能分支，日常工作流程如下：

去自己的工作分支
$ git checkout work

工作
....

提交工作分支的修改
$ git commit -a

回到主分支
$ git checkout master

获取远程最新的修改，此时不会产生冲突
$ git pull

回到工作分支
$ git checkout work

用rebase合并主干的修改，如果有冲突在此时解决
$ git rebase master

回到主分支
$ git checkout master

合并工作分支的修改，此时不会产生冲突。
$ git merge work

提交到远程主干
$ git push
```
