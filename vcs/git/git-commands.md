# Git常用命令

## 放弃本地修改

1. 放弃暂存区某些 `文件/目录` 修改，已经 `git add`，`git add` 反向操作

```sh
git reset HEAD path/to/directory/or/file
git reset HEAD .
```

2. 放弃工作区某些 `文件/目录` 修改，没有 `git add`

```sh
git checkout -- path/to/directory/or/file
```

```sh
git checkout .
```

```sh
git clean -xdf
```
