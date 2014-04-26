# git
+ ``git help <verb>``,``git <verb> --help``,``man git-<verb>``
## ``git config``,``/etc/gitconfig``,``$HOME/.gitconfig``,``.git/config``
```bash
[color]
    ui = auto
[color "branch"]
    current = yellow reverse
    local = yellow
    remote = green
[color "diff"]
    meta = yellow bold
    frag = magenta bold
    old = red bold
    new = green bold
[color "status"]
    added = yellow
    changed = green
    untracked = cyan
```
+ 工作目录下面的所有文件都不外乎这两种状态：已跟踪或未跟踪。已跟踪的文件是指本来就被纳入版本控制管理的文件，在上次快照中有它们的记录，工作一段时间后，它们的状态可能是未更新，已修改或者已放入暂存区。而所有其他文件都属于未跟踪文件。它们既没有上次更新时的快照，也不在当前的暂存区域。初次克隆某个仓库时，工作目录中的所有文件都属于已跟踪文件，且状态为未修改。
+ git add 的潜台词就是把目标文件快照放入暂存区域，也就是 add file into staged area，同时未曾跟踪过的文件标记为需要跟踪。
+ ``benchmarks.rb`` 文件出现了两次！一次算未暂存，一次算已暂存，这怎么可能呢？好吧，实际上 Git 只不过暂存了你运行 ``git add``命令时的版本，如果现在提交，那么提交的是此次修改前的版本，而非当前工作目录中的版本。所以，运行了``git add`` 之后又作了修订的文件，需要重新运行``git add`` 把最新版本重新暂存起来。
+ 文件``.gitignore``的格式规范如下：
  + 所有空行或者以注释符号 ＃ 开头的行都会被 Git 忽略。
  + 可以使用标准的 glob 模式匹配。
  + 匹配模式最后跟反斜杠（/）说明要忽略的是目录。
  + 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。
```bash
# 此为注释 – 将被 Git 忽略
# 忽略所有 .a 结尾的文件
*.a
# 但 lib.a 除外
!lib.a
# 仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
/TODO
# 忽略 build/ 目录下的所有文件
build/
# 会忽略 doc/notes.txt 但不包括 doc/server/arch.txt
doc/*.txt
```

+ ``git diff``比较的是工作目录中当前文件和暂存区域快照之间的差异，也就是修改之后还没有暂存起来的变化内容。要看已经暂存起来的文件和上次提交时的快照之间的差异，可以用 ``git diff --staged``.单单 ``git diff`` 不过是显示还没有暂存起来的改动，而不是这次工作和上次提交之间的差异。所以有时候你一下子暂存了所有更新过的文件后，运行 ``git diff`` 后却什么也没有，就是这个原因。
+ 尽管使用暂存区域的方式可以精心准备要提交的细节，但有时候这么做略显繁琐。Git 提供了一个跳过使用暂存区域的方式，只要在提交的时候，给 git commit 加上 -a 选项，Git 就会自动把所有已经跟踪过的文件暂存起来一并提交，从而跳过 git add 步骤。
+ 要从 Git 中移除某个文件，就必须要从已跟踪文件清单中移除（确切地说，是从暂存区域移除），然后提交。可以用 git rm 命令完成此项工作，并连带从工作目录中删除指定的文件，这样以后就不会出现在未跟踪文件清单中了。最后提交的时候，该文件就不再纳入版本管理了。如果删除之前修改过并且没有把修改放到暂存区域的话，则必须要用强制删除选项 -f。
```bash
hrh@Solarex:tmp$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#   new file:   test.test
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#   modified:   test.test
#
hrh@Solarex:tmp$ git rm test.test
error: 'tmp/test.test' has staged content different from both the file and the HEAD
(use -f to force removal)                                                      ```

我们想把文件从 Git 仓库中删除（亦即从暂存区域移除），但仍然希望保留在当前工作目录中。换句话说，仅是从跟踪清单中删除。比如一些大型日志文件或者一堆 .a 编译文件，不小心纳入仓库后，要移除跟踪但不删除文件，以便稍后在 ``.gitignore`` 文件中补上，用 --cached 选项即可。``git rm --cached readme.txt``
+ 运行``git mv`` 就相当于运行了下面三条命令：``mv readme.txt readme;git rm readme.txt; git add readme``
+ ``git log``，``-p``展开显示每次提交的内容差异，``-2`` 则仅显示最近的两次更新。此外，还有许多摘要选项可以用，比如 ``--stat``，仅显示简要的增改行数统计。``git log --pretty=online|short|full|fuller``，``git log --pretty=format:"%h - %an, %ar : %s"``。
```bash
%H 提交对象（commit）的完整哈希字串
%h 提交对象的简短哈希字串
%T 树对象（tree）的完整哈希字串
%t 树对象的简短哈希字串
%P 父对象（parent）的完整哈希字串
%p 父对象的简短哈希字串
%an 作者（author）的名字
%ae 作者的电子邮件地址
%ad 作者修订日期（可以用 -date= 选项定制格式）
%ar 作者修订日期，按多久以前的方式显示
%cn 提交者(committer)的名字
%ce 提交者的电子邮件地址
%cd 提交日期
%cr 提交日期，按多久以前的方式显示
%s 提交说明
```
用 ``oneline`` 或 ``format`` 时结合 ``--graph`` 选项，可以看到开头多出一些 ASCII 字符串表示的简单图形。
```bash
-p 按补丁格式显示每个更新之间的差异。
--stat 显示每次更新的文件修改统计信息。
--shortstat 只显示 --stat 中最后的行数修改添加移除统计。
--name-only 仅在提交信息后显示已修改的文件清单。
--name-status 显示新增、修改、删除的文件清单。
--abbrev-commit 仅显示 SHA-1 的前几个字符，而非所有的 40 个字符。
--relative-date 使用较短的相对时间显示（比如，“2 weeks ago”）。
--graph 显示 ASCII 图形表示的分支合并历史。
--pretty 使用其他格式显示历史提交信息。可用的选项包括 oneline，short，full，fuller 和 format（后跟指定格式）。
```
还有按照时间作限制的选项，比如 ``--since`` 和 ``--until``。还可以给出若干搜索条件，列出符合的提交。用 ``--author`` 选项显示指定作者的提交，用 ``--grep`` 选项搜索提交说明中的关键字。（请注意，如果要得到同时满足这两个选项搜索条件的提交，就必须用 ``--all-match`` 选项。否则，满足任意一个条件的提交都会被匹配出来）
