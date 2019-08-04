# Git 清理提交历史

## git filter-branch

清理指定文件的历史

```sh
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch FILENAME' --prune-empty --tag-name-filter cat -- --all
```

清理指定目录的历史

```sh
git filter-branch --force --index-filter 'git rm -r --cached --ignore-unmatch test' --prune-empty --tag-name-filter cat -- --all
```

如果待清理的文件很多，又不在相同的位置，清理起来将会很麻烦

执行完成后，归档历史已经清理完成，但还有一些垃圾文件，用下面的命令清理

```sh
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now
```

强制推送到远程仓库

```sh
git push origin --force --all
git push origin --force --tags
```

此时其他小伙伴需要重新clone代码到本地，因为提交历史被修改了，远程仓库很可能会与本地仓库冲突。
所以在清理时，应提前提醒其他小伙伴提交代码。

## BFG Repo-Cleaner

* https://github.com/rtyley/bfg-repo-cleaner
